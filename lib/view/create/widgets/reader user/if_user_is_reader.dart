import 'package:flutter/material.dart';
import 'package:tech_node/core/custom/custom_text_style.dart';

class IfUserIsReader extends StatelessWidget {
  const IfUserIsReader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CustomTextStyle(text: "you are reader"),),
    );
  }
}