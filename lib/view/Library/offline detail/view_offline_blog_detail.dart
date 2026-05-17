import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tech_node/core/constants/themes.dart';
import 'package:tech_node/data%20local/local%20Models/offline_blogs_model.dart';
import 'package:tech_node/view/Library/offline%20detail/widget/offline_app_bar.dart';
import 'package:tech_node/view/Library/offline%20detail/widget/offline_author.dart';
import 'package:tech_node/view/Library/offline%20detail/widget/offline_blog_content.dart';
import 'package:tech_node/view/Library/offline%20detail/widget/offline_title.dart';

class ViewOfflineBlogDetail extends StatelessWidget {
  final OfflineBlogsModel theBlog;
  const ViewOfflineBlogDetail({super.key, required this.theBlog});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              pinned: false,
              snap: true,
              backgroundColor: background,
              expandedHeight: 47,
              collapsedHeight: 45,
              toolbarHeight: 45,
              leading: null,
              surfaceTintColor: background,
              automaticallyImplyLeading: false,
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: EdgeInsets.zero,
                expandedTitleScale: 1.0,
                title: OfflineAppBar(blogDetail: theBlog),
              ),
            ),
            if (theBlog.thumbnail != null && theBlog.thumbnail!.isNotEmpty)
              SliverToBoxAdapter(
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Hero(
                    tag: '${theBlog.id}image',
                    child: Image.file(File(theBlog.thumbnail!), fit: .cover),
                  ),
                ),
              ),
            SliverToBoxAdapter(
              child: OfflineTitle(
                blogtitle: theBlog.title,
                categoryName: theBlog.categoryName,
              ),
            ),
            SliverToBoxAdapter(
              child: OfflineAuthor(
                id: theBlog.authorID,
                name: theBlog.authorName,
                image: theBlog.authorImage,
                publishedAt: theBlog.publishedAt,
              ),
            ),
            SliverToBoxAdapter(
              child: OfflineBlogContent(content: theBlog.content),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 30)),
          ],
        ),
      ),
    );
  }
}
