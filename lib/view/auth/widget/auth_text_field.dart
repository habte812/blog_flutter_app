import 'package:flutter/material.dart';
import 'package:tech_node/core/constants/themes.dart';

class AuthTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String label;
  final IconData icon;
  final bool isPassword;
  final TextInputType? keyboardType;
  final List<String>? autofillHints;
  final FormFieldValidator<String>? validator;
  final int? maxLength;
  const AuthTextField({
    super.key,
    this.controller,
    required this.icon,
    required this.isPassword,
    required this.label,
    this.keyboardType,
    this.autofillHints,
    this.validator,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      maxLength: maxLength,
      controller: controller,
      autofillHints: autofillHints,
      keyboardType: keyboardType,
      obscureText: isPassword,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        counterText: '',
        prefixIcon: Icon(icon, color: Colors.white38),
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white38),
        filled: true,
        errorStyle: const TextStyle(color: Colors.redAccent),
        fillColor: Colors.white.withValues(alpha: 0.05),
        enabledBorder: OutlineInputBorder(
          borderRadius: .circular(15),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: .circular(15),
          borderSide:  BorderSide(color: context.primary, width: 1),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: .circular(15),
          borderSide: const BorderSide(color: Colors.redAccent, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: .circular(15),
          borderSide: const BorderSide(color: Colors.redAccent, width: 1),
        ),
      ),
    );
  }
}
