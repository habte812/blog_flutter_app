import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:tech_node/core/constants/themes.dart';
import 'package:tech_node/core/custom/custom_button.dart';
import 'package:tech_node/core/custom/custom_text_style.dart';

class EmptyStateSection extends StatelessWidget {
  final double hPad;
  const EmptyStateSection({super.key, required this.hPad});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: hPad),
      child: Column(
        children: [
          const SizedBox(height: 24),
          Icon(LucideIcons.users, size: 80, color: context.primary),
          const SizedBox(height: 28),

          const CustomTextStyle(
            text: 'Stay in the loop',
            textAlign: TextAlign.center,
            fontSize: 28,
            fontWeight: FontWeight.bold,
            letterSpacing: -0.8,
          ),
          const SizedBox(height: 12),
          const CustomTextStyle(
            text:
                'Sign in to follow your favorite authors\nand get their latest stories delivered\nright here — all in one place.',
            textAlign: TextAlign.center,
            fontSize: 15,
            textColor: Colors.white70,
          ),

          const SizedBox(height: 28),

          const Wrap(
            alignment: WrapAlignment.center,
            spacing: 8,
            runSpacing: 8,
            children: [
              _FeaturePill(
                icon: LucideIcons.sparkles,
                label: 'Personalised feed',
              ),
              _FeaturePill(
                icon: LucideIcons.bookOpen,
                label: 'Curated stories',
              ),
              _FeaturePill(icon: LucideIcons.users, label: 'Community picks'),
            ],
          ),
          const SizedBox(height: 28),

          CustomButton(
            height: 54,
            onPressed: () {
              context.push('/login_page');
            },
            label: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomTextStyle(
                  text: 'Sign in to Follow',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.1,
                ),
                SizedBox(width: 8),
                Icon(LucideIcons.arrowRight, size: 18),
              ],
            ),
          ),

          const SizedBox(height: 12),
          TextButton(
            onPressed: () {
              context.push('/login_page/register_page');
            },
            style: TextButton.styleFrom(
              foregroundColor: background,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
            child: const CustomTextStyle(
              text: 'Create a free account',

              fontSize: 13,
              decoration: TextDecoration.underline,
            ),
          ),

          const SizedBox(height: 8),
          const _DividerWithLabel(label: 'or explore first'),
        ],
      ),
    );
  }
}

class _FeaturePill extends StatelessWidget {
  final IconData icon;
  final String label;
  const _FeaturePill({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: card),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: context.primary),
          const SizedBox(width: 5),
          CustomTextStyle(text: label, fontSize: 12),
        ],
      ),
    );
  }
}

class _DividerWithLabel extends StatelessWidget {
  final String label;
  const _DividerWithLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider(color: Colors.white54, thickness: 1)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: CustomTextStyle(
            text: label,
            fontSize: 11,
            textColor: Colors.white54,
            letterSpacing: 0.5,
          ),
        ),
        const Expanded(child: Divider(color: Colors.white54, thickness: 1)),
      ],
    );
  }
}
