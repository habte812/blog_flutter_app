import 'package:flutter/material.dart';
import 'package:tech_node/core/custom/custom_text_style.dart';

class BlogTitle extends StatelessWidget {
  const BlogTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding:  .all(16),
      child: CustomTextStyle(
        text: "Learn Flutter and Laravel API with Habtemariam",
        fontSize: 30,
        fontWeight: FontWeight.w900,
      ),
    );
  }
}
