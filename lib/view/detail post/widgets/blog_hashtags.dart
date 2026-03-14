import 'package:flutter/material.dart';
import 'package:tech_node/core/constants/themes.dart';
import 'package:tech_node/core/custom/custom_text_style.dart';

class BlogHashtags extends StatelessWidget {
  const BlogHashtags({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> hashtags = [
      'habte',
      'blog',
      'sportInTheWorld',
      'africa',
      'arsenalAndCity',
      'manUnited',
    ];
    return Column(
      crossAxisAlignment: .start,
      children: [
        Divider(thickness: 0.4, endIndent: 20, indent: 20),
        Padding(
          padding: const .symmetric(horizontal: 16.0),
          child: Wrap(
            runSpacing: 8,
            spacing: 10,
            children: hashtags
                .map(
                  (tags) => CustomTextStyle(
                    text: "#$tags",
                    fontSize: 15,
                    textColor: primary,
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}
