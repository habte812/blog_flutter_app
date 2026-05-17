import 'package:flutter/material.dart';
import 'package:tech_node/core/constants/themes.dart';
import 'package:tech_node/core/custom/custom_text_style.dart';

class ExpandedTileBuilder extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData icon;
  final Widget childs;
  final Widget? trailingWidget;
  const ExpandedTileBuilder({
    super.key,
    required this.title,
    this.subtitle,
    required this.icon,
    required this.childs,
    this.trailingWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const .only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.03),
        borderRadius: .circular(12),
      ),
      child: ExpansionTile(
        tilePadding: const .symmetric(horizontal: 16, vertical: 4),
        collapsedShape: RoundedRectangleBorder(borderRadius: .circular(12)),
        shape: RoundedRectangleBorder(borderRadius: .circular(12)),
        backgroundColor: Colors.transparent,
        leading: Container(
          padding: const .all(8),
          decoration: BoxDecoration(
            color: context.primary.withValues(alpha: 0.1),
            borderRadius: .circular(8),
          ),
          child: Icon(icon, color: context.primary),
        ),
        title: CustomTextStyle(
          text: title,
          textColor: Colors.white,
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
            trailingWidget ??
            const Icon(
              Icons.keyboard_arrow_down_outlined,
              color: Colors.white10,
              size: 20,
            ),
        children: [childs],
      ),
    );
  }
}
