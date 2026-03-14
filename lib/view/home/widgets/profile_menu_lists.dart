import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:tech_node/core/constants/themes.dart';
import 'package:tech_node/core/custom/custom_text_style.dart';

class ProfileMenuLists extends StatelessWidget {
  const ProfileMenuLists({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      tooltip: 'Profile',
      color: background.withValues(alpha: 0.95),
      elevation: 10,
      padding: .all(0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(color: Colors.white10),
      ),
      offset: const Offset(0, 50),
      icon: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: primary.withValues(alpha: 0.5), width: 2),
        ),
        child: const CircleAvatar(
          radius: 18,
          backgroundColor: background,
          child: Icon(LucideIcons.user, size: 18, color: Colors.white),
        ),
      ),
      onSelected: (value) {
        if (value == 'profile') {
          if (!context.mounted) return;
          context.pushNamed('profile');
        }
      },
      itemBuilder: (context) => [
        _buildPopupItem('Profile', LucideIcons.user, 'profile'),
        _buildPopupItem('Share', LucideIcons.share2, 'share'),
        const PopupMenuDivider(height: 1),
        _buildPopupItem(
          'Log out',
          LucideIcons.logOut,
          'Log out',
          isDestructive: true,
        ),
      ],
    );
  }
}

PopupMenuItem<String> _buildPopupItem(
  String title,
  IconData icon,
  String value, {
  bool isDestructive = false,
}) {
  return PopupMenuItem(
    value: value,
    child: Row(
      children: [
        Icon(
          icon,
          size: 18,
          color: isDestructive ? Colors.redAccent : Colors.white70,
        ),
        const SizedBox(width: 12),
        CustomTextStyle(
          text: title,
          fontSize: 14,
          textColor: isDestructive ? Colors.redAccent : Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ],
    ),
  );
}
