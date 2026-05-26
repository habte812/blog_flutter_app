import 'package:flutter/material.dart';

class DraftBlogs extends StatelessWidget {
  const DraftBlogs({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 20,

      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(color: Colors.amber, height: 40),
        );
      },
    );
  }
}
