import 'package:flutter/material.dart';
import 'package:tech_node/core/constants/themes.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget label;
  final Widget? icon;
  final double? width;
  final double? height;
  final Color? backgroundColor;
  final double? textSize;
  final EdgeInsets? padding;
  const CustomButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.icon,
    this.textSize,
    this.width,
    this.backgroundColor,
    this.height,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      width: width,
      height: height ?? 60,
      decoration: BoxDecoration(
        color: backgroundColor == Colors.transparent ? Colors.white30 : primary,
        border: backgroundColor == Colors.transparent
            ? Border.all(
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withValues(alpha: 0.2),
              )
            : null,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(10),
          child: Center(
            child: Row(
              mainAxisSize: .min,
              children: [
                if (icon != null) ...[icon!, const SizedBox(width: 8)],
                const SizedBox(width: 3),
                label,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
