import 'package:flutter/material.dart';
import 'package:tech_node/core/constants/themes.dart';
import 'package:tech_node/core/custom/custom_button.dart';
import 'package:tech_node/core/custom/custom_text_style.dart';

class UploadThumbnail extends StatelessWidget {
  const UploadThumbnail({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const .all(16),
      padding: const .all(10),
      decoration: BoxDecoration(
        color: card,
        borderRadius: .circular(10),
        border: .all(color: Colors.white24),
      ),
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Image.asset('assets/images/im5.jpg', fit: BoxFit.cover),
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              const CustomTextStyle(
                text: "Upload Thumbnail",
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              CustomButton(
                width: 100,
                height: 40,
                onPressed: () {},
                label: const CustomTextStyle(text: 'Upload', fontSize: 16),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
