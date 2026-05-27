import 'package:flutter/material.dart';
import 'package:tech_node/core/custom/custom_loading.dart';
import 'package:tech_node/core/custom/custom_text_style.dart';

class CustomBottomLoader extends StatelessWidget {
  final bool isLoadingMore;
  final bool hasMorePages;
  final String endTitle;
  final bool isEmpty;
  final Widget? loaderSize;
  const CustomBottomLoader({
    super.key,
    required this.isLoadingMore,
    required this.hasMorePages,
    required this.endTitle,
    required this.isEmpty,
    this.loaderSize
  });
  @override
  Widget build(BuildContext context) {
    if (isLoadingMore) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: loaderSize ?? const Center(child: CustomLoading()),
      );
    }

    if (!hasMorePages && !isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
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
