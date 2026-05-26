import 'package:flutter/material.dart';
import 'package:tech_node/core/constants/themes.dart';
import 'package:tech_node/core/custom/custom_button.dart';
import 'package:tech_node/core/custom/custom_text_style.dart';

class FinalContinueLogin extends StatelessWidget {
  const FinalContinueLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 32, 16, 0),
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: card,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: context.primary.withValues(alpha: 0.2)),
      ),
      child: Column(
        children: [
          // Pen icon
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: context.primary,
              shape: BoxShape.circle,
              border: Border.all(color: context.primary.withValues(alpha: 0.3)),
              boxShadow: [
                BoxShadow(
                  color: context.primary.withValues(alpha: 0.2),
                  blurRadius: 20,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Icon(Icons.create_rounded, size: 26, color: context.primary),
          ),
          const SizedBox(height: 18),
          const CustomTextStyle(
          text:   'Ready to share your voice?',
            textAlign: TextAlign.center,
              fontSize: 20,
              fontWeight: FontWeight.w700,
              
              letterSpacing: -0.3,
            ),
          
          const SizedBox(height: 10),
          const CustomTextStyle(
           text:  'Join thousands of writers who publish their\nbest work here every day.',
            textAlign: TextAlign.center,
           
              fontFamily: 'Georgia',
              fontSize: 13,
              textColor: Colors.white54,
             
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  backgroundColor: Colors.transparent,
                  height: 50,
                  onPressed: () {},
                  label: const CustomTextStyle(
                    text: 'Create Account',
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: CustomButton(
                  height: 50,
                  onPressed: () {},
                  label: const CustomTextStyle(
                    text: 'Sign in',
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
