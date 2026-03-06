import 'package:flutter/material.dart';
import 'package:learn_shan/screen/detail_screen.dart';
import 'package:learn_shan/utilities/utils.dart' show words;
import 'package:learn_shan/widget/mao_grid_item.dart';

class TableScreen extends StatelessWidget {
  final String word;

  const TableScreen({super.key, required this.word});

  void _gotoDetailScreen(BuildContext context, String categoryId, String id) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => DetailScreen(id: id, categoryId: categoryId),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Light grey-blue background for a modern feel
      backgroundColor: const Color(0xFFF1F5F9),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          word, // The category name (e.g., "တူဝ်ၽႅတ်း - မ")
          style: const TextStyle(
            fontFamily: "AJ",
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        children: [
          // Header Decoration
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            decoration: const BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: const Text(
              "လိူၵ်ႈသဵင်သေသွၼ်ႁဵၼ်းတူၺ်းၶႃႈ", // "Select a sound to learn"
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: "AJ",
                color: Colors.white70,
                fontSize: 16,
              ),
            ),
          ),

          // The Grid
          Expanded(
            child: Center(
              child: Container(
                // Prevents the grid from becoming too wide on Ultra-Wide monitors
                constraints: const BoxConstraints(maxWidth: 1000),
                child: GridView.builder(
                  padding: const EdgeInsets.all(20),
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    // Forces items to be roughly 140px wide.
                    // On Desktop, this adds more columns. On Mobile, it maintains ~3.
                    maxCrossAxisExtent: 100,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio:
                        1.0, // Ensures items stay perfectly square
                  ),
                  itemCount: words[word]?.length ?? 0,
                  itemBuilder: (context, index) {
                    final str = words[word]![index];
                    return MaoGridItem(
                      text: str,
                      onPressed: (id) {
                        _gotoDetailScreen(context, word, id);
                      },
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
