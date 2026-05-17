import 'package:flutter/material.dart';
import 'package:tech_node/core/constants/themes.dart';
import 'package:tech_node/core/custom/custom_text_style.dart';

class SettingsTileBuilder extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final Color? textColor;
  final VoidCallback? onTap;
  const SettingsTileBuilder({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.trailing,
    this.textColor = Colors.white,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const .only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.03),
        borderRadius: .circular(12),
      ),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: .circular(12)),
        onTap: onTap,
        contentPadding: const .symmetric(horizontal: 16, vertical: 4),

        leading: Container(
          padding: const .all(8),
          decoration: BoxDecoration(
            color: context.primary.withValues(alpha: 0.1),
            borderRadius: .circular(8),
          ),
          child: Icon(
            icon,
            color: textColor == Colors.white ? context.primary : textColor,
            size: 22,
          ),
        ),
        title: CustomTextStyle(
          text: title,
          textColor: textColor,
          fontSize: 15,
          fontWeight: .w600,
        ),
        subtitle: subtitle != null
            ? CustomTextStyle(
                text: subtitle!,
                textColor: Colors.white38,
                fontSize: 12,
                fontWeight: .normal,
              )
            : null,
        trailing:
            trailing ??
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.white10,
              size: 14,
            ),
      ),
    );
  }
}
