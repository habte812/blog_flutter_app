import 'package:flutter/material.dart';
import 'package:tech_node/core/constants/themes.dart';
import 'package:tech_node/core/custom/custom_button.dart';
import 'package:tech_node/core/custom/custom_text_style.dart';
import 'package:tech_node/view/auth/forgot%20password/reset_password_page.dart';
import 'package:tech_node/view/auth/widget/auth_text_field.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

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
              const SizedBox(height: 20),
              const CustomTextStyle(
                text: "Forgot\nPassword?",
                textColor: Colors.white,
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(height: 15),
              const CustomTextStyle(
                text:
                    "Don't worry! Enter your email address and we will send you a code to reset your password.",
                textColor: Colors.white54,
                fontSize: 16,
              ),

              const SizedBox(height: 50),

              AuthTextField(
                icon: Icons.email_outlined,
                isPassword: false,
                label: "Email Address",
                keyboardType: TextInputType.emailAddress,
              ),

              const SizedBox(height: 40),
              CustomButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ResetPasswordPage(),
                    ),
                  );
                },
                label: const CustomTextStyle(
                  text: "Send Reset Link",
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
// "Check your inbox for instructions to reset your password.",