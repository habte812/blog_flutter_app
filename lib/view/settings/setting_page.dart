import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tech_node/core/constants/themes.dart';
import 'package:tech_node/core/custom/custom_text_style.dart';
import 'package:tech_node/view/settings/widgets/settings_tile_builder.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      children: [
        const SizedBox(height: 30),
        SectionHeader(title: "Account & Security"),
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

        SectionHeader(title: "Content Preferences"),
        SettingsTileBuilder(
          icon: Icons.image_outlined,
          title: "Image Quality",
          subtitle: "High (Uses more data)",
          trailing: const Icon(
            Icons.keyboard_arrow_down,
            color: Colors.white24,
          ),
          onTap: () {},
        ),
        SettingsTileBuilder(
          icon: Icons.delete_sweep_outlined,
          title: "Clear Cache",
          subtitle: "Currently using 124MB",
          onTap: () {
          },
        ),

        const SizedBox(height: 25),

        SectionHeader(title: "Notifications"),
        SettingsTileBuilder(
          icon: Icons.notifications_none,
          title: "Push Notifications",
          subtitle: "Alerts for new posts and likes",
          trailing: Switch(
            value: true,
            onChanged: (v) {},
            activeColor: primary,
            trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
          ),
        ),

        const SizedBox(height: 25),

        SectionHeader(title: "General"),
        SettingsTileBuilder(
          icon: Icons.description_outlined,
          title: "Terms of Service",
          onTap: () {},
        ),
        SettingsTileBuilder(
          icon: Icons.info_outline,
          title: "App Version",
          subtitle: "v1.0.2-stable",
          onTap: null, // Just info
        ),

        const SizedBox(height: 40),

        Center(
          child: TextButton(
            onPressed: () {
            },
            child: const CustomTextStyle(
              text: "Logout Account",
              textColor: Colors.redAccent,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 80),
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
        textColor: primary,
        fontSize: 12,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
