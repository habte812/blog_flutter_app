import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:tech_node/core/constants/themes.dart';
import 'package:tech_node/core/custom/custom_text_style.dart';

class ReaderUserAppBar extends StatelessWidget {
  const ReaderUserAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      pinned: false,
      snap: true,
      backgroundColor: background,
      expandedHeight: 47,
      collapsedHeight: 45,
      toolbarHeight: 45,
      leading: null,
      surfaceTintColor: background,
      automaticallyImplyLeading: false,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: EdgeInsets.zero,
        expandedTitleScale: 1.0,
        title: Row(
          children: [
            IconButton(
              highlightColor: background,
              splashColor: background,
              onPressed: () {
                if (!context.mounted) return;
                if (context.canPop()) {
                  context.pop();
                } else {
                  context.go('/home');
                }
              },
              icon: const Icon(LucideIcons.arrowLeft, color: Colors.white),
            ),
            const CustomTextStyle(
              text: 'Create Post',
              fontSize: 20,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.3,
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: context.primary,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Row(
                children: [
                  Icon(Icons.lock_outline_rounded, size: 11),
                  SizedBox(width: 5),
                  CustomTextStyle(
                    text: "Reader Tier",
                    fontSize: 11,
                    letterSpacing: 0.2,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}