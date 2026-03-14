import 'package:flutter/material.dart';
import 'package:tech_node/core/custom/custom_text_style.dart';

class CustomPopupMenuItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final String value;
  final bool? isDestructive;
  const CustomPopupMenuItem({
    super.key,
    required this.icon,
    this.isDestructive = false,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuItem(
      value: value,
      child: Row(
        children: [
          Icon(
            icon,
            size: 18,
            color: isDestructive! ? Colors.redAccent : Colors.white70,
          ),
          const SizedBox(width: 12),
          CustomTextStyle(
            text: title,
            fontSize: 14,
            textColor: isDestructive! ? Colors.redAccent : Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ],
      ),
    );
  }
}
