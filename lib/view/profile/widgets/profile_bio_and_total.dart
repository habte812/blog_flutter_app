import 'package:flutter/material.dart';
import 'package:tech_node/core/custom/custom_text_style.dart';

class ProfileBioAndTotal extends StatelessWidget {
  const ProfileBioAndTotal({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          CircleAvatar(
            radius: 45,
            backgroundColor: Colors.white10,
            backgroundImage: const AssetImage("assets/images/im4.jpg"),
          ),
          const SizedBox(height: 10),
          const CustomTextStyle(
            text: "Habtemariam Melsie",
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          const CustomTextStyle(
            text: "Flutter Developer | ECE Graduate 2025 Flutter Developer",
            textColor: Colors.white70,
            textAlign: TextAlign.center,
            maxLine: 2,
            fontSize: 14,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: .spaceAround,
              children: [
                _buildStatColumn("Posts", "24"),
                _buildStatColumn("Views", "1.2k"),
                _buildStatColumn("Shares", "85"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
Widget _buildStatColumn(String label, String count) {
  return Column(
    children: [
      CustomTextStyle(text: count, fontSize: 18, fontWeight: FontWeight.bold),
      CustomTextStyle(text: label, fontSize: 12, textColor: Colors.white54),
    ],
  );
}
