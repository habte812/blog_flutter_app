import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:tech_node/core/constants/themes.dart';
import 'package:tech_node/core/custom/custom_text_style.dart';

class CustomBannerCard extends StatelessWidget {
  const CustomBannerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: primary,
      child: Row(
        children: [
          const Icon(LucideIcons.mailWarning, color: Colors.white, size: 24),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomTextStyle(
                  text: "Verify your email",
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  textColor: Colors.white,
                ),
                Expanded(
                  child: CustomTextStyle(
                    text: "Please check your inbox to continue.",
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
            label: const CustomTextStyle(text: "Resend", fontSize: 16),
            icon: const Icon(
              LucideIcons.refreshCcw,
              size: 18,
              color: Colors.white70,
            ),
            onPressed: () =>context.pushNamed('login'),
          ),
        ],
      ),
    );
  }
}

class PersistentBannerDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  PersistentBannerDelegate({required this.child});

  @override
  double get minExtent => 72.0;
  @override
  double get maxExtent => 72.0;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return child;
  }

  @override
  bool shouldRebuild(covariant PersistentBannerDelegate oldDelegate) {
    return true;
  }
}
