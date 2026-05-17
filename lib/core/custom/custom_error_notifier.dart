import 'package:flutter/material.dart';
import 'package:tech_node/core/constants/themes.dart';
import 'package:tech_node/core/custom/custom_text_style.dart';

class CustomErrorNotifier extends StatelessWidget {
  final String errorMessage;
  final VoidCallback action;
  final Color? textColor;
  const CustomErrorNotifier({
    super.key,
    required this.action,
    required this.errorMessage,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const .all(8.0),
        child: Column(
          mainAxisSize: .min,
          crossAxisAlignment: .center,
          children: [
             const Icon(
              Icons.error_outline_rounded,
              color: Colors.white24,
              size: 56,
            ),
            const SizedBox(height: 16),
            CustomTextStyle(
              text: errorMessage,
              textAlign: .center,
              fontSize: 14,
              textColor: Colors.white54,
              fontWeight: FontWeight.bold,
            ),
            TextButton.icon(
              style: ButtonStyle(iconColor: .all(textColor ?? context.primary)),
              onPressed: action,
              icon: const Icon(Icons.refresh),
              label: CustomTextStyle(
                text: "Try again",
                fontSize: 14,
                textColor: textColor ?? context.primary,
                fontWeight: FontWeight.bold,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
