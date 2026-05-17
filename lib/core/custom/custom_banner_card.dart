import 'package:flutter/material.dart';
import 'package:tech_node/core/constants/themes.dart';
import 'package:tech_node/core/custom/custom_text_style.dart';

class CustomBannerCard extends StatelessWidget {
  final String title;
  final String subTitle;
  final IconData prefixIcon;
  final IconData buttonIcon;
  final String buttonTitle;
  final VoidCallback onPressed;
  final Color? color;
  const CustomBannerCard({
    super.key,
    required this.title,
    required this.subTitle,
    required this.prefixIcon,
    required this.buttonIcon,
    required this.buttonTitle,
    required this.onPressed,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: color ?? context.primary,
      child: Row(
        children: [
          Icon(prefixIcon, color: Colors.white, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomTextStyle(
                  text: title,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  textColor: Colors.white,
                ),
                Expanded(
                  child: CustomTextStyle(
                    text: subTitle,
                    overflow: TextOverflow.ellipsis,
                    maxLine: 1,
                    fontSize: 12,
                    textColor: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
          TextButton.icon(
            label: CustomTextStyle(text: buttonTitle, fontSize: 16),
            icon: Icon(buttonIcon, size: 18, color: Colors.white70),
            onPressed: onPressed,
          ),
        ],
      ),
    );
  }
}

class PersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double? extent;
  PersistentHeaderDelegate({required this.child, this.extent});

  @override
  double get minExtent => extent ?? 72.0;
  @override
  double get maxExtent => extent ?? 72.0;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return SizedBox(height: extent ?? 72, child: child);
  }

  @override
  bool shouldRebuild(covariant PersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
