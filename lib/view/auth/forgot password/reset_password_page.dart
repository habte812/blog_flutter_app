import 'package:flutter/material.dart';
import 'package:tech_node/core/constants/themes.dart';
import 'package:tech_node/core/custom/custom_button.dart';
import 'package:tech_node/core/custom/custom_text_style.dart';
import 'package:tech_node/view/auth/widget/auth_text_field.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: background,
        surfaceTintColor: background,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomTextStyle(
                text: "Reset\nPassword",

                textColor: Colors.white,
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(height: 15),
              const CustomTextStyle(
                text:
                    "Please enter your new password below. Make sure it's strong and unique.",
                textColor: Colors.white54,
                fontSize: 16,
              ),

              const SizedBox(height: 40),

              AuthTextField(
                icon: Icons.lock_outline,
                isPassword: true,
                label: "New Password",
                keyboardType: TextInputType.none,
              ),
              const SizedBox(height: 20),

              AuthTextField(
                icon: Icons.lock_reset,
                isPassword: true,
                label: "Confirm New Password",
                keyboardType: TextInputType.none,
              ),

              const SizedBox(height: 40),

              CustomButton(
                onPressed: () {},
                label: const CustomTextStyle(
                  text: "Update Password",
                  textColor: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
