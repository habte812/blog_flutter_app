import 'package:flutter/material.dart';
import 'package:tech_node/core/constants/themes.dart';
import 'package:tech_node/core/custom/custom_text_style.dart';

class WhatYouGetAfter extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  const WhatYouGetAfter({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0, left: 16, right: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.02),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: context.primary, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextStyle(
                  text: title,
                  textColor: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
                const SizedBox(height: 4),
                CustomTextStyle(
                  text: description,
                  textColor: Colors.white38,
                  fontSize: 12,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
