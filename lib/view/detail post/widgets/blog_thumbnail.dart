import 'package:flutter/material.dart';

class BlogThumbnail extends StatelessWidget {
  const BlogThumbnail({super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Image.asset('assets/images/im6.jpg', fit: BoxFit.cover),
    );
  }
}
