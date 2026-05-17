import 'package:flutter/material.dart';
import 'package:tech_node/core/custom/custom_text_style.dart';

class FilterFeeds extends StatelessWidget {
  const FilterFeeds({super.key});

  @override
  Widget build(BuildContext context) {
    return 
          const Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              spacing: 25,
              children: [
                CustomTextStyle(
                  text: "For you",
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                CustomTextStyle(
                  text: "Latest",
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  textColor: Colors.white30,
                ),
                CustomTextStyle(
                  text: "Trending",
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  textColor: Colors.white30,
                ),
              ],
            ),
          );
  }
}