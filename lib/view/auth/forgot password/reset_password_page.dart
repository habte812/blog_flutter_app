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
import 'package:tech_node/data/viewModel/auth/auth_notifier.dart';
import 'package:tech_node/view/auth/widget/auth_text_field.dart';

class ResetPasswordPage extends HookConsumerWidget {
  final String token;
  final String email;
  const ResetPasswordPage({
    super.key,
    required this.email,
    required this.token,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(authProvider, (prev, next) {
      if (next.lastAction == AuthAction.resetPasswordPage) {
        if (prev?.status == AuthStatus.loading) {
          if (next.status != AuthStatus.loading &&
              next.status != AuthStatus.error) {
            CustomScaffoldMessage.show(
              context,
              message: 'Password Updated successfully',
            );
            if (!context.mounted) return;
            context.go('/home');
          }
        }

        if (next.status == AuthStatus.error) {
          if (!context.mounted) return;
          CustomScaffoldMessage.show(
            context,
            message: next.errorMessage ?? 'Unknown Error',
            isError: true,
          );
        }
      }
    });
    final newpasswordController = useTextEditingController();
    final newpasswordConfiController = useTextEditingController();
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
                CustomTextStyle(text: email, fontSize: 14),
                CustomTextStyle(text: token, fontSize: 14),
                AuthTextField(
                  controller: newpasswordController,
                  icon: Icons.lock_outline,
                  isPassword: true,
                  label: "New Password",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the new password';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                AuthTextField(
                  controller: newpasswordConfiController,
                  icon: Icons.lock_reset,
                  isPassword: true,
                  label: "Confirm New Password",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter password here again';
                    }
                    if (newpasswordConfiController.text.trim() !=
                        newpasswordController.text.trim()) {
                      return 'Password doesn\'t match';
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
                        if (globaKey.currentState!.validate()) {
                          await ref
                              .read(authProvider.notifier)
                              .resetTheNewPassword(
                                email: email,
                                token: token,
                                newPassword: newpasswordController.text.trim(),
                                newConPassword: newpasswordConfiController.text
                                    .trim(),
                              );
                        }
                      },
                      label: authstate.status == AuthStatus.loading
                          ? const CustomLoading(color: Colors.white)
                          : const CustomTextStyle(
                              text: "Update Password",
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
