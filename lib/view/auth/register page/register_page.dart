import 'package:flutter/material.dart';
import 'package:tech_node/core/constants/themes.dart';
import 'package:tech_node/core/custom/custom_button.dart';
import 'package:tech_node/core/custom/custom_text_style.dart';
import 'package:tech_node/view/auth/widget/auth_text_field.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: background,
        surfaceTintColor: background,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 80),
            const CustomTextStyle(
              text: "Create\nAccount",
              textColor: Colors.white,
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(height: 10),
            const CustomTextStyle(
              text:
                  "Join a community of writers and share your story with the world.",
              textColor: Colors.white54,
              fontSize: 16,
            ),
            const SizedBox(height: 50),
            AuthTextField(
              label: "Full Name",
              icon: Icons.person_outline,
              isPassword: false,
              keyboardType: TextInputType.name,
            ),
            const SizedBox(height: 20),
            AuthTextField(
              label: "Email",
              icon: Icons.email_outlined,
              isPassword: false,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 20),
            AuthTextField(
              label: "Password",
              icon: Icons.lock_outline,
              isPassword: true,
              keyboardType: TextInputType.none,
            ),
            const SizedBox(height: 20),
            AuthTextField(
              icon: Icons.lock_reset,
              isPassword: true,
              label: "Confirm Password",
              keyboardType: TextInputType.none,
            ),

            const SizedBox(height: 40),

            CustomButton(
              onPressed: () {},
              label: CustomTextStyle(
                text: "Create Account",
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 1000),
          ],
        ),
      ),
    );
  }
}
