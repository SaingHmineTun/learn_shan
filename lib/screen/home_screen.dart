import 'package:flutter/material.dart';
import 'package:learn_shan/screen/table_screen.dart';
import 'package:learn_shan/widget/mao_list_item.dart';
import 'package:learn_shan/utilities/utils.dart' show words;

import 'about_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _gotoTableScreen(BuildContext ctx, String word) {
    Navigator.of(
      ctx,
    ).push(MaterialPageRoute(builder: (ctx) => TableScreen(word: word)));
  }

  void _gotoAboutScreen(BuildContext ctx) {
    Navigator.of(ctx).push(MaterialPageRoute(builder: (ctx) => AboutScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC), // Modern off-white background
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              _gotoAboutScreen(context);
            },
            icon: Icon(Icons.info_outline, color: Colors.white),
          ),
        ],
        title: const Text(
          "သွၼ်ႁဵၼ်းလိၵ်ႈတႆး", // "Learn Shan Language"
          style: TextStyle(
            fontFamily: "AJ",
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        children: [
          // Banner / Welcome Area
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: const BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(32),
                bottomRight: Radius.circular(32),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "မႂ်ႇသုင်ၶႃႈ", // "Greeting"
                  style: TextStyle(
                    fontFamily: "AJ",
                    fontSize: 28,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "လိူၵ်ႈလွင်ႈတေသွၼ်ႁဵၼ်းဝႆႉၶႃႈ", // "Choose a lesson"
                  style: TextStyle(
                    fontFamily: "AJ",
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),

          // Lesson List
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              itemCount: words.keys.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final str = words.keys.elementAt(index);
                return MaoListItem(
                  text: str,
                  onPressed: (word) => _gotoTableScreen(context, word),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
