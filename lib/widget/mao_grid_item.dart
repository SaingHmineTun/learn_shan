import 'package:flutter/material.dart';

class MaoGridItem extends StatelessWidget {
  final String text;
  final void Function(String str) onPressed;

  const MaoGridItem({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white,
            Colors.blue.shade100, // Very subtle blue tint at bottom
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.blueAccent.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: Colors.blueAccent.withAlpha(150),
          width: 2,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => onPressed(text),
          splashColor: Colors.blueAccent.withOpacity(0.1),
          highlightColor: Colors.blueAccent.withOpacity(0.05),
          child: Center(
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: "AJ",
                fontSize: 16, // Increased for better readability
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E293B), // Dark slate for high contrast
              ),
            ),
          ),
        ),
      ),
    );
  }
}