import 'package:flutter/material.dart';
import 'package:tech_node/core/constants/themes.dart';
import 'package:tech_node/core/custom/custom_text_style.dart';
import 'package:tech_node/data/model/blog/blogs_detail_model.dart';

class BlogTitle extends StatelessWidget {
  final BlogsDetailModel blogDetail;
  const BlogTitle({super.key, required this.blogDetail});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const .all(16),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          Container(
            margin: const .only(bottom: 12),
            padding: const .symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: context.primary,
              borderRadius: .circular(6),
            ),
            child: CustomTextStyle(
              text: blogDetail.previewDatas.category.name,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          CustomTextStyle(
            text: blogDetail.previewDatas.title,
            fontSize: 30,
            fontWeight: FontWeight.w900,
          ),
        ],
      ),
    );
  }
}
