import 'package:flutter/material.dart';
import 'package:tech_node/core/custom/custom_loading.dart';
import 'package:tech_node/core/custom/custom_text_style.dart';

class CustomBottomLoader extends StatelessWidget {
  final bool isLoadingMore;
  final bool hasMorePages;
  final String endTitle;
  final bool isEmpty;
  const CustomBottomLoader({
    super.key,
    required this.isLoadingMore,
    required this.hasMorePages,
    required this.endTitle,
    required this.isEmpty,
  });
  @override
  Widget build(BuildContext context) {
    if (isLoadingMore) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 24),
        child: Center(child: CustomLoading()),
      );
    }

    if (!hasMorePages && !isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 28),
        child: Center(
          child: CustomTextStyle(
            text: endTitle,
            textColor: Colors.white.withValues(alpha: 0.25),
            fontSize: 13,
          ),
        ),
      );
    }

    return const SizedBox(height: 24);
  }
}
