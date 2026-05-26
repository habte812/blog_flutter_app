import 'package:flutter/material.dart';
import 'package:tech_node/core/custom/custom_text_style.dart';

class SectionLabel extends StatelessWidget {
  final String label;
  const SectionLabel({super.key, required this.label});

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(20, 28, 20, 14),
    child: Row(
      children: [
        CustomTextStyle(
          text: label.toUpperCase(),
          fontSize: 10,
          fontWeight: FontWeight.w700,
          textColor: Colors.white30,
          letterSpacing: 2.0,
        ),
        const SizedBox(width: 12),
        const Expanded(child: Divider(height: 1, color: Colors.white12)),
      ],
    ),
  );
}
