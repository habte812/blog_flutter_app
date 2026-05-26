import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:tech_node/core/constants/themes.dart';
import 'package:tech_node/core/custom/custom_button.dart';
import 'package:tech_node/core/custom/custom_text_style.dart';
import 'package:tech_node/core/theme/provider/theme_color_notifier.dart';
import 'package:tech_node/view/profile/widgets/guest/guest_profile_appbar.dart';
import 'package:tech_node/view/settings/widgets/cache/cache_widget.dart';
import 'package:tech_node/view/settings/widgets/expanded_tile_builder.dart';
import 'package:tech_node/view/settings/widgets/settings_tile_builder.dart';
import 'package:tech_node/view/settings/widgets/theme/theme_widget.dart';

class GuestProfile extends StatelessWidget {
  const GuestProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const GuestProfileAppbar(),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 40.0,
                horizontal: 24.0,
              ),
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.05),
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white10, width: 2),
                        ),
                        child: const Icon(
                          LucideIcons.user,
                          size: 50,
                          color: Colors.white38,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: context.primary,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          LucideIcons.lock,
                          size: 14,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const CustomTextStyle(
                    text: "Guest Account",

                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    textColor: Colors.white,
                  ),
                  const SizedBox(height: 8),
                  const CustomTextStyle(
                    text:
                        "Join TechNode to publish articles, bookmark stories, and customize your creative space.",
                    textAlign: TextAlign.center,

                    fontSize: 14,
                    textColor: Colors.white38,
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  CustomButton(
                    height: 52,
                    onPressed: () {
                      context.push('/login_page');
                    },
                    label: const Row(
                      mainAxisSize: .min,
                      children: [
                        CustomTextStyle(
                          text: "Sign in to Profile",
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
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                    ),
                    child: RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.white38,
                        ),
                        children: [
                          const TextSpan(text: "Don't have an account? "),
                          TextSpan(
                            text: 'Create a free account→',
                            style: TextStyle(
                              color: context.primary,
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.underline,
                              decorationColor: context.primary.withValues(
                                alpha: 0.4,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                  child: Row(
                    children: [
                      CustomTextStyle(
                        text: 'Preferences'.toUpperCase(),
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.8,
                        textColor: Colors.white54,
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Divider(color: Colors.white54, height: 1),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Consumer(
                  builder: (context, ref, child) {
                    final themeColor = ref.watch(themeColorProvider);
                    return ExpandedTileBuilder(
                      icon: Icons.palette_outlined,
                      title: "Accent Color",
                      subtitle: "Change the primary color of icons and buttons",
                      trailingWidget: CircleAvatar(
                        radius: 10,
                        backgroundColor: themeColor,
                      ),
                      childs: const ThemeWidget(),
                    );
                  },
                ),
                const ExpandedTileBuilder(
                  icon: Icons.delete_sweep_outlined,
                  title: "Storage & Cache",
                  subtitle: "Currently using 124MB",

                  childs: CacheWidget(),
                ),
                SettingsTileBuilder(
                  icon: Icons.view_comfy_alt_outlined,
                  title: "Layout Style",
                  subtitle: "Change the layout of the app",
                  onTap: () {},
                ),
                SettingsTileBuilder(
                  icon: Icons.info_outline,
                  title: "About BlogNode",
                  onTap: () {},
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
