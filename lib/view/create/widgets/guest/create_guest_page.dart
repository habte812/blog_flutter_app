import 'package:flutter/material.dart';
import 'package:tech_node/core/custom/custom_text_style.dart';

class CreateGuestPage extends StatelessWidget {
  const CreateGuestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            const CustomTextStyle(
              text: 'You need to login to and get verified to become author',
            ),
          ],
        ),
      ),
    );
  }
}
