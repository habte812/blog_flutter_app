import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:tech_node/core/custom/custom_text_style.dart';
import 'package:tech_node/view/home/widgets/profile_menu_lists.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomTextStyle(
                text: "Welcome Back",
                fontSize: 22,
                fontWeight: FontWeight.w900,
                textColor: Colors.white,
              ),
              const SizedBox(height: 4),
              CustomTextStyle(
                text: "Explore the world",
                fontSize: 12,
                textColor: Colors.white.withValues(alpha: 0.6),
              ),
              const SizedBox(height: 5),
            ],
          ),

          Row(
            children: [
              IconButton(
                icon: const Icon(
                  LucideIcons.bell,
                  color: Colors.white,
                  size: 20,
                ),
                onPressed: () => context.pushNamed('notification'),
              ),
              const SizedBox(width: 8),

              const ProfileMenuLists(),
            ],
          ),
        ],
      ),
    );
  }
}
