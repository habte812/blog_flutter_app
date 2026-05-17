import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tech_node/core/constants/themes.dart';
import 'package:tech_node/core/custom/custom_button.dart';
import 'package:tech_node/core/custom/custom_loading.dart';
import 'package:tech_node/core/custom/custom_sacffold_message.dart';
import 'package:tech_node/core/custom/custom_text_style.dart';
import 'package:tech_node/data/model/auth/auth_state.dart';
import 'package:tech_node/data/viewModel/auth/auth_notifier.dart';
import 'package:tech_node/view/auth/widget/auth_text_field.dart';

class ForgotPassword extends HookConsumerWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = useTextEditingController();
    ref.listen(authProvider, (prev, next) {
      if (prev?.status == AuthStatus.loading &&
          next.status != AuthStatus.error &&
          next.lastAction == AuthAction.resetPasswordlink) {
        CustomScaffoldMessage.show(
          context,
          message: 'Reset link sent successfully, please check you email',
        );
        emailController.clear();
      } else if (next.status == AuthStatus.error) {
        CustomScaffoldMessage.show(
          context,
          message: next.errorMessage ?? 'Unknown Error',
          isError: true,
        );
      }
    });
    final formKey = useMemoized(() => GlobalKey<FormState>());
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
            key: formKey,
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
                  controller: emailController,
                  icon: Icons.email_outlined,
                  isPassword: false,
                  label: "Email Address",
                  keyboardType: TextInputType.emailAddress,
                  autofillHints: [AutofillHints.email],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email address';
                    }
                    if (!value.contains('@')) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 40),
                Consumer(
                  builder: (context, ref, child) {
                    final authstate = ref.watch(authProvider);
                    return CustomButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          await ref
                              .read(authProvider.notifier)
                              .sendPasswordResetLink(
                                email: emailController.text.trim(),
                              );
                        }
                      },
                      label: authstate.status == AuthStatus.loading
                          ? const CustomLoading(color: Colors.white)
                          : const CustomTextStyle(
                              text: "Send Reset Link",
                              textColor: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
