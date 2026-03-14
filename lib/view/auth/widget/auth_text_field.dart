import 'package:flutter/material.dart';
import 'package:tech_node/core/constants/themes.dart';

class AuthTextField extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isPassword;
  final TextInputType keyboardType;
  const AuthTextField({
    super.key,
    required this.icon,
    required this.isPassword,
    required this.label,
    required this.keyboardType
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      obscureText: isPassword,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.white38),
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white38),
        filled: true,
        fillColor: Colors.white.withValues(alpha: 0.05),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: primary, width: 1),
        ),
      ),
    );
  }
}
