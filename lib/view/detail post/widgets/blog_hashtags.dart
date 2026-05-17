import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tech_node/core/constants/themes.dart';
import 'package:tech_node/core/custom/custom_text_style.dart';
import 'package:tech_node/data/model/blog/blogs_detail_model.dart';

class BlogHashtags extends StatelessWidget {
  final BlogsDetailModel blogDetail;
  const BlogHashtags({super.key, required this.blogDetail});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        const Divider(thickness: 0.4, endIndent: 20, indent: 20),
        Padding(
          padding: const .symmetric(horizontal: 16.0),
          child: Wrap(
            runSpacing: 8,
            spacing: 10,
            children: blogDetail.seos.metaKeywords
                .split(',')
                .map(
                  (tags) => GestureDetector(
                    onTap: () => context.pushNamed('search'),
                    child: CustomTextStyle(
                      text: "#$tags",
                      fontSize: 15,
                      textColor: context.primary,
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}
