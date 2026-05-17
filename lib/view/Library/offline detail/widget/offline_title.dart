import 'package:flutter/material.dart';
import 'package:tech_node/core/constants/themes.dart';
import 'package:tech_node/core/custom/custom_text_style.dart';

class OfflineTitle extends StatelessWidget {
  final String blogtitle;
  final String categoryName;
  const OfflineTitle({
    super.key,
    required this.blogtitle,
    required this.categoryName,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const .all(16),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          Container(
            margin: const .only(bottom: 12),
            padding: const .symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: context.primary,
              borderRadius: .circular(6),
            ),
            child: CustomTextStyle(
              text: categoryName,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          CustomTextStyle(
            text: blogtitle,
            fontSize: 30,
            fontWeight: FontWeight.w900,
          ),
        ],
      ),
    );
  }
}