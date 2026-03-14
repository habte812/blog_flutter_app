import 'package:flutter/material.dart';
import 'package:tech_node/core/commen/today_featured_blog.dart';

class TodaysFeaturedBlogsList extends StatelessWidget {
  const TodaysFeaturedBlogsList({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 366,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 5,
          itemBuilder: (context, index) {
            return TodayFeaturedBlog();
          },
        ),
      ),
    );
  }
}
