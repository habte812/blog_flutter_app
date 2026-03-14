import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tech_node/core/constants/themes.dart';
import 'package:tech_node/core/custom/custom_button.dart';
import 'package:tech_node/core/custom/custom_text_style.dart';
import 'package:tech_node/view/auth/widget/auth_text_field.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
              const SizedBox(height: 80),
              const CustomTextStyle(
                text: "Welcome\nBack",

                textColor: Colors.white,
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(height: 10),
              const CustomTextStyle(
                text: "Login to continue your blogging journey.",
                textColor: Colors.white54,
                fontSize: 16,
              ),

              const SizedBox(height: 50),

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

              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    if (!context.mounted) return;
                    context.pushNamed('forgot_password');
                  },
                  child: const CustomTextStyle(
                    fontSize: 14,
                    text: "Forgot Password?",
                    textColor: primary,
                  ),
                ),
              ),

              const SizedBox(height: 30),

              CustomButton(
                onPressed: () {
                },
                label: CustomTextStyle(
                  text: "Login",
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CustomTextStyle(
                    text: "Don't have an account?",
                    fontSize: 14,
                    textColor: Colors.white54,
                  ),

                  TextButton(
                    onPressed: () => context.pushNamed('register'),
                    child: const CustomTextStyle(
                      text: "Sign Up",
                      fontSize: 14,
                      textColor: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
