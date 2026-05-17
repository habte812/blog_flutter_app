import 'package:flutter/material.dart';
import 'package:tech_node/view/Library/widgets/saved_blogs_list.dart';

class MyPostedBlogs extends StatelessWidget {
  const MyPostedBlogs({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 20,
      itemBuilder: (context, index) {
        return Container(color: Colors.amber,height: 40,);
      },
    );
  }
}
