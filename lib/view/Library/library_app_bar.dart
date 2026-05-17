import 'package:flutter/material.dart';
import 'package:tech_node/core/constants/themes.dart';
import 'package:tech_node/core/custom/custom_text_style.dart';

class LibraryAppBar extends StatelessWidget {
  const LibraryAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const SliverAppBar(
      floating: true,
      title: CustomTextStyle(
        text: "My Library",
        fontSize: 28,
        fontWeight: FontWeight.bold,
      ),
      backgroundColor: background,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
    );
  }
}
