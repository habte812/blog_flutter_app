import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:tech_node/core/constants/themes.dart';
import 'package:tech_node/core/custom/custom_text_style.dart';

class ExploareAppBar extends StatelessWidget {
  const ExploareAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      backgroundColor: background,
      surfaceTintColor: background,
      title: GestureDetector(
        onTap: () => context.pushNamed('search'),
        child: Container(
          width: double.infinity,
          margin: .symmetric(horizontal: 8, vertical: 8),
          padding: .all(10),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(10),
          ),

          child: Row(
            children: [
              Icon(LucideIcons.search, color: Colors.white38),
              const SizedBox(width: 10),
              CustomTextStyle(
                text: 'Search blogs, authors...',
                fontSize: 15,
                textColor: Colors.white38,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
