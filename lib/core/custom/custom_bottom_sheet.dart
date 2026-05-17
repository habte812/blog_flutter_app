import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tech_node/core/constants/themes.dart';
import 'package:tech_node/core/custom/custom_text_style.dart';

class CustomBottomSheet {
  static void show({
    required BuildContext context,
    Widget? topTitle,
    required Widget child,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.8,
        minChildSize: 0.4,
        maxChildSize: 0.9,
        builder: (context2, scrollController) {
          return Container(
            decoration: const BoxDecoration(
              color: background,
              borderRadius: .vertical(top: Radius.circular(20)),
            ),
            child: Column(
              children: [
                Center(
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 12),
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey[600],
                      borderRadius: .circular(10),
                    ),
                  ),
                ),

                Padding(
                  padding: const .only(bottom: 5, right: 10, left: 10),
                  child: Row(
                    mainAxisAlignment: .spaceBetween,
                    children: [
                      topTitle ??
                          const CustomTextStyle(
                            text: '',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                      IconButton(
                        onPressed: () {
                          if (!context2.mounted) return;
                          context2.pop();
                        },
                        icon: const Icon(Icons.close, color: Colors.white54),
                      ),
                    ],
                  ),
                ),
                Expanded(child: child),
              ],
            ),
          );
        },
      ),
    );
  }
}
