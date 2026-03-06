import 'package:flutter/material.dart';

class MaoListItem extends StatelessWidget {
  final String text;
  final void Function(String str) onPressed;

  const MaoListItem({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4), // Space between items
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: Colors.blueAccent.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => onPressed(text),
          splashColor: Colors.blueAccent.withOpacity(0.05),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                // Leading Icon/Decoration
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.blueAccent.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.menu_book_rounded,
                    color: Colors.blueAccent,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 16),

                // The Main Text
                Expanded(
                  child: Text(
                    text,
                    style: const TextStyle(
                      fontFamily: "AJ",
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF334155), // Slate-700 for better legibility
                    ),
                  ),
                ),

                // Trailing Arrow
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.grey.withOpacity(0.5),
                  size: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}