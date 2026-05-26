import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:tech_node/core/constants/themes.dart';
import 'package:tech_node/core/custom/custom_button.dart';
import 'package:tech_node/core/custom/custom_text_style.dart';

class SavedEmptyState extends StatelessWidget {
  const SavedEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 44, 24, 36),
      child: Column(
        children: [
          Icon(Icons.bookmark_border_rounded, size: 80, color: context.primary),
          const SizedBox(height: 32),
          const CustomTextStyle(
            text: 'Your reading heart\nis empty for now',
            textAlign: .center,
            fontSize: 26,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.5,
          ),
          const SizedBox(height: 14),
          const CustomTextStyle(
            text:
                'Sign in to bookmark the stories that move you — '
                'articles, essays, and ideas you want to return to, '
                'all in one beautiful place.',
            textAlign: .center,
            textColor: Colors.white54,
            fontSize: 15,
          ),
          const SizedBox(height: 32),
          CustomButton(
            height: 52,
            onPressed: () {
              context.push('/login_page');
            },
            label: const Row(
              mainAxisSize: .min,
              children: [
                CustomTextStyle(
                  text: 'Sign in to Save Favorites',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.1,
                ),
                SizedBox(width: 8),
                Icon(LucideIcons.arrowRight, size: 18),
              ],
            ),
          ),

          TextButton(
            onPressed: () {
              context.push('/login_page/register_page');
            },
            style: TextButton.styleFrom(
              foregroundColor: background,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
            child: RichText(
              text: TextSpan(
                style: const TextStyle(fontSize: 13, color: Colors.white38),
                children: [
                  const TextSpan(text: "Don't have an account? "),
                  TextSpan(
                    text: 'Create a free account→',
                    style: TextStyle(
                      color: context.primary,
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.underline,
                      decorationColor: context.primary.withValues(alpha: 0.4),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
