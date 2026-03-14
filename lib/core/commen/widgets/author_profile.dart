import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:tech_node/core/constants/themes.dart';
import 'package:tech_node/core/custom/custom_text_style.dart';

class AuthorProfile extends StatelessWidget {
  final double radius;
  const AuthorProfile({super.key, required this.radius});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: radius,
          backgroundColor: primary,
          backgroundImage: AssetImage('assets/images/im4.jpg'),
        ),
        SizedBox(width: 8),
        Expanded(
          flex: 10,
          child: Column(
            crossAxisAlignment: .start,
            children: [
              CustomTextStyle(
                text: 'Habtemariambbbbbbbbbbbbb',
                overflow: TextOverflow.visible,
                textColor: Colors.white54,
                maxLine: 1,
                fontSize: 14,
              ),
              CustomTextStyle(
                text: 'Mar 10',
                overflow: TextOverflow.visible,
                textColor: Colors.white54,
                maxLine: 1,
                fontSize: 10,
              ),
            ],
          ),
        ),
        Spacer(),
        Icon(LucideIcons.eye, color: Colors.white54, size: 20),
        SizedBox(width: 4),
        CustomTextStyle(text: '14K', fontSize: 12),
        SizedBox(width: 10),
        Icon(LucideIcons.bookmark, color: Colors.white54, size: 20),
      ],
    );
  }
}
