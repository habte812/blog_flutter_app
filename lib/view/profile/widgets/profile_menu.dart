import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:tech_node/core/constants/themes.dart';
import 'package:tech_node/core/custom/custom_text_style.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      tooltip: 'settings',
      elevation: 10,
      padding: .all(0),
      offset: const Offset(0, 50),
      color: background,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(color: Colors.white10), 
      ),
      icon: SizedBox(child: Icon(LucideIcons.settings2, color: Colors.white)),
      onSelected: (value) {
        if (value == 'edit') {
        if (!context.mounted) return;
          context.pushNamed('edit_profile');
        }
      },
      itemBuilder: (context) => [
        _buildPopupItem('Edit', LucideIcons.edit2, 'edit'),
        _buildPopupItem('Change Password', Icons.password_outlined, 'password'),
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
