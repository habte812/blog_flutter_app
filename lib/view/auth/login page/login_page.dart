import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tech_node/core/constants/themes.dart';
import 'package:tech_node/core/custom/custom_button.dart';
import 'package:tech_node/core/custom/custom_loading.dart';
import 'package:tech_node/core/custom/custom_sacffold_message.dart';
import 'package:tech_node/core/custom/custom_text_style.dart';
import 'package:tech_node/data/model/auth/auth_state.dart';
import 'package:tech_node/data/repository/auth/auth_repository.dart';
import 'package:tech_node/data/viewModel/auth/auth_notifier.dart';
import 'package:tech_node/view/auth/widget/auth_text_field.dart';

class LoginPage extends HookConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(authProvider, (prev, next) {
      if (next.status == AuthStatus.error) {
        CustomScaffoldMessage.show(
          context,
          message: next.errorMessage ?? 'Unknown Error',
          isError: true,
        );
      }
      if (next.status == AuthStatus.authenticated ||
          next.status == AuthStatus.unverified) {
        CustomScaffoldMessage.show(context, message: 'Welcome back');

        if (!context.mounted) return;
        context.pop();
      }
    });
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final globaKey = useMemoized(() => GlobalKey<FormState>());
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
          child: Form(
            key: globaKey,
            child: Column(
              crossAxisAlignment: .start,
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
                  controller: emailController,
                  label: "Email",
                  icon: Icons.email_outlined,
                  isPassword: false,
                  keyboardType: TextInputType.emailAddress,
                  autofillHints: [AutofillHints.email],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                AuthTextField(
                  controller: passwordController,
                  label: "Password",
                  icon: Icons.lock_outline,
                  isPassword: true,
                  autofillHints: [AutofillHints.password],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter password';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      if (!context.mounted) return;
                      context.pushNamed('forgot_password');
                    },
                    child:  CustomTextStyle(
                      fontSize: 14,
                      text: "Forgot Password?",
                      textColor: context.primary,
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                Consumer(
                  builder: (context, ref, child) {
                    final theauth = ref.watch(authProvider);
                    return CustomButton(
                      onPressed: () {
                        if (globaKey.currentState!.validate()) {
                          final authRepo = ref.read(authRepositoryProvider);
                          ref
                              .read(authProvider.notifier)
                              .authenticate(
                                authRepo.login(
                                  email: emailController.text.trim(),
                                  password: passwordController.text,
                                ),
                              );
                        }
                      },
                      label: theauth.status == AuthStatus.loading
                          ? const CustomLoading(color: Colors.white)
                          : const CustomTextStyle(
                              text: "Login",
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                    );
                  },
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
                      onPressed: () => context.pushReplacementNamed('register'),
                      child:  CustomTextStyle(
                        text: "Sign Up",
                        fontSize: 14,
                        textColor: context.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
