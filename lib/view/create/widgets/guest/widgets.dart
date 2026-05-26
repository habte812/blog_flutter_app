import 'package:flutter/material.dart';
import 'package:tech_node/core/constants/themes.dart';
import 'package:tech_node/core/custom/custom_text_style.dart';

class StatPill extends StatelessWidget {
  final String value;
  final String label;
  final Color color;
  const StatPill({
    super.key,
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) => Expanded(
    child: Column(
      children: [
        CustomTextStyle(
          text: value,
          fontSize: 20,
          fontWeight: FontWeight.w700,
          textColor: color,
          letterSpacing: -0.5,
        ),
        const SizedBox(height: 3),
        CustomTextStyle(text: label, fontSize: 11),
      ],
    ),
  );
}

class VertDivider extends StatelessWidget {
  const VertDivider({super.key});

  @override
  Widget build(BuildContext context) =>
      Container(width: 1, height: 36, color: card);
}

class StoryCard {
  final String title;
  final String author;
  final String reads;
  final String tag;
  final Color tagColor;
  final Color avatarColor;
  const StoryCard({
    required this.title,
    required this.author,
    required this.reads,
    required this.tag,
    required this.tagColor,
    required this.avatarColor,
  });
}
