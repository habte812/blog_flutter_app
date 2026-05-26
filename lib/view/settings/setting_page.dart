import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tech_node/app/scroll_provider.dart';
import 'package:tech_node/core/theme/provider/theme_color_notifier.dart';
import 'package:tech_node/core/constants/themes.dart';
import 'package:tech_node/core/custom/custom_text_style.dart';
import 'package:tech_node/view/settings/widgets/cache/cache_widget.dart';
import 'package:tech_node/view/settings/widgets/expanded_tile_builder.dart';
import 'package:tech_node/view/settings/widgets/settings_tile_builder.dart';
import 'package:tech_node/view/settings/widgets/theme/theme_widget.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final sattingCon = ScrollProvider.of(context).sattingController;
    return ListView(
      controller: sattingCon,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      children: [
        const SizedBox(height: 30),
        const SectionHeader(title: "Account & Security"),
        SettingsTileBuilder(
          icon: Icons.person_outline,
          title: "Personal Information",
          subtitle: "Name, email, and bio",
          onTap: () => context.pushNamed('edit_profile'),
        ),
        SettingsTileBuilder(
          icon: Icons.shield_outlined,
          title: "Password & Security",
          subtitle: "Two-factor auth and reset",
          onTap: () {},
        ),

        const SizedBox(height: 25),

        const SectionHeader(title: "Content Preferences"),
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
        SettingsTileBuilder(
          icon: Icons.view_comfy_alt_outlined,
          title: "Layout Style",
          subtitle: "Change the layout of the app",
          onTap: () {},
        ),
        const SizedBox(height: 25),
        const SectionHeader(title: "Data & Storage"),
        SettingsTileBuilder(
          icon: Icons.wifi_off_outlined,
          title: "Offline Reading",
          subtitle: "Manage downloaded articles",
          onTap: () {},
        ),
        const ExpandedTileBuilder(
          icon: Icons.delete_sweep_outlined,
          title: "Clear Cache",
          subtitle: "Currently using 124MB",

          childs: CacheWidget(),
        ),
        const SizedBox(height: 25),

        const SectionHeader(title: "Notifications"),
        SettingsTileBuilder(
          icon: Icons.notifications_none,
          title: "Push Notifications",
          subtitle: "Alerts for new posts and likes",
          trailing: Switch(
            value: true,
            onChanged: (v) {},
            activeThumbColor: context.primary,
            trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
          ),
        ),

        const SizedBox(height: 25),
        const SectionHeader(title: "Support"),

        SettingsTileBuilder(
          icon: Icons.bug_report_outlined,
          title: "Report a Bug",
          subtitle: "Help us improve the app",
          onTap: () {},
        ),
        SettingsTileBuilder(
          icon: Icons.share_outlined,
          title: "Invite Friends",
          subtitle: "Share this app with other readers",
          onTap: () {},
        ),
        const SizedBox(height: 25),
        const SectionHeader(title: "General"),
        SettingsTileBuilder(
          icon: Icons.description_outlined,
          title: "Terms of Service",
          onTap: () {},
        ),
        SettingsTileBuilder(
          icon: Icons.info_outline,
          title: "About BlogNode",
          onTap: () {},
        ),
        const SettingsTileBuilder(
          icon: Icons.update_outlined,
          title: "Check for Updates",
          subtitle: "Current version: 1.0.0",
          onTap: null,
        ),
        const SizedBox(height: 40),
        Center(
          child: TextButton(
            onPressed: () {},
            child: const CustomTextStyle(
              text: "Logout Account",
              textColor: Colors.redAccent,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;
  const SectionHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, left: 4),
      child: CustomTextStyle(
        text: title.toUpperCase(),
        textColor: context.primary,
        fontSize: 12,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
