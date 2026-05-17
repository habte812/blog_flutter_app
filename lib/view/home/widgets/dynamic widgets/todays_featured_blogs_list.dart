import 'package:flutter/material.dart';
import 'package:tech_node/core/commen/today_featured_blog.dart';
import 'package:tech_node/data/model/blog/blogs_preview_model.dart';

class TodaysFeaturedBlogsList extends StatelessWidget {
  final List<BlogsPreviewModel> blogModel;
  const TodaysFeaturedBlogsList({super.key, required this.blogModel});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 373,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: blogModel.length,
          itemBuilder: (context, index) {
            return TodayFeaturedBlog(blogModel: blogModel[index]);
          },
        ),
      ),
    );
  }
}
