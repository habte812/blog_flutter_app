import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:tech_node/core/constants/themes.dart';
import 'package:tech_node/core/custom/custom_text_style.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: background,
        elevation: 0,
        centerTitle: true,
        scrolledUnderElevation: 0.5,
        leading: IconButton(
          icon: const Icon(
            LucideIcons.arrowLeft,
            size: 22,
            color: Colors.white,
          ),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            }
          },
        ),
        title: const CustomTextStyle(
          text: 'Notification',
          fontWeight: FontWeight.w800,
          fontSize: 18,
        ),
      ),
      body: const Center(
        child: CustomTextStyle(text: 'Notification', fontSize: 40),
      ),
    );
  }
}
