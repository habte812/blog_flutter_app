import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:tech_node/core/constants/themes.dart';
import 'package:tech_node/core/custom/custom_text_style.dart';

class AuthorProfile extends StatelessWidget {
  const AuthorProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: .start,
      mainAxisSize: .min,
      children: [
        Padding(
          padding: .all(16),
          child: Row(
            crossAxisAlignment: .start,
            mainAxisSize: .min,
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: primary,
                backgroundImage: AssetImage('assets/images/im4.jpg'),
              ),
              SizedBox(width: 8),
              Column(
                crossAxisAlignment: .start,
                children: [
                  CustomTextStyle(
                    text: 'Habtemariam Melsie',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  CustomTextStyle(
                    text: 'Mar 10',
                    fontSize: 15,
                    textColor: Colors.white70,
                  ),
                ],
              ),
              Spacer(),
              Icon(LucideIcons.eye, color: Colors.grey),
              SizedBox(width: 4),
              CustomTextStyle(text: '14K', fontSize: 14),
              SizedBox(width: 12),
              Icon(Icons.comment, color: Colors.grey),
            ],
          ),
        ),
        Divider(thickness: 0.1, endIndent: 20, indent: 20),
      ],
    );
  }
}
