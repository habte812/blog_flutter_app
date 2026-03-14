import 'package:flutter/material.dart';
import 'package:tech_node/core/custom/custom_text_field.dart';

class TitleContainer extends StatelessWidget {
  const TitleContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: .all(16),
      child: CustomTextField(
        label: 'Title',
        contentPadding: .symmetric(horizontal: 10, vertical: 5),
        hintText: 'Write your title',
        fontWeight: FontWeight.bold,
        textStyle: TextStyle(
          fontSize: 20,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
