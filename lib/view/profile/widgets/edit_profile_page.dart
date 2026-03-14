import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tech_node/core/constants/themes.dart';
import 'package:tech_node/core/custom/custom_text_field.dart';
import 'package:tech_node/core/custom/custom_text_style.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            }
          },
        ),
        title: const CustomTextStyle(
          text: "Edit Profile",
          textColor: Colors.white,
          fontSize: 18,
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: const CustomTextStyle(
              text: "Save",
              textColor: Colors.blue,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const .all(20),
        children: [
          Center(
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.white10,
                  backgroundImage: const AssetImage("assets/images/im4.jpg"),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          CustomTextField(
            label: "Full Name",
            initialValue: "Habtemariam Melsie",
            maxLines: 1,
            contentPadding: .all(10),
          ),
          const SizedBox(height: 20),
          CustomTextField(
            label: "Bio",
            initialValue: "Flutter Developer | ECE Graduate 2025",
            maxLines: 3,
            contentPadding: .all(10),
            maxLength: 55,
          ),
          const SizedBox(height: 20),
          const CustomTextStyle(
            text: "Private Information",
            textColor: Colors.white54,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(height: 10),
          CustomTextField(
            label: "Email",
            initialValue: "habtemariammelsie@gmail.com",
            maxLines: 1,
            contentPadding: .all(10),
          ),
        ],
      ),
    );
  }
}
