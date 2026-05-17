import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:tech_node/core/constants/themes.dart';
import 'package:tech_node/core/custom/custom_button.dart';
import 'package:tech_node/core/custom/custom_loading.dart';
import 'package:tech_node/core/custom/custom_text_style.dart';

Future<void> customShowDialog(
  BuildContext context, {
  required String title,
  required String subTitle,
  required VoidCallback onCancel,
  required VoidCallback onRight,
  required String rightButtonText,
  required bool Function() isLoading,
  String? cancelButtonText,
  IconData? icon,
  Color? iconColor,
}) async {
  return showDialog(
    context: context,
    barrierDismissible: !isLoading(),
    builder: (dialogContext) => StatefulBuilder(
      builder: (context, setState) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Dialog(
            backgroundColor: background,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: .min,
                children: [
                  Icon(
                    icon ?? LucideIcons.alertTriangle,
                    size: 40,
                    color: iconColor ?? Colors.blueAccent,
                  ),
                  const SizedBox(height: 16),
                  CustomTextStyle(
                    text: title,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(height: 10),
                  CustomTextStyle(
                    text: subTitle,
                    fontSize: 14,
                    textColor: Colors.white54,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: isLoading()
                              ? null
                              : () {
                                  Navigator.of(dialogContext).pop();
                                  onCancel();
                                },
                          child: CustomTextStyle(
                            fontSize: 14,
                            text: cancelButtonText ?? "Cancel",
                            textColor: Colors.redAccent,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: CustomButton(
                          backgroundColor: isLoading()
                              ? Colors.transparent
                              : null,
                          height: 45,
                          onPressed: isLoading()
                              ? null
                              : () {
                                  onRight();
                                  setState(() {});
                                },
                          label: isLoading()
                              ? const SizedBox(
                                  width: 40,
                                  height: 40,
                                  child: CustomLoading(color: Colors.white),
                                )
                              : CustomTextStyle(
                                  text: rightButtonText,
                                  fontSize: 14,
                                ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    ),
  );
}
