import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:tech_node/core/constants/themes.dart';
import 'package:tech_node/core/custom/custom_text_style.dart';
import 'package:tech_node/view/detail%20post/widgets/author_profile.dart';
import 'package:tech_node/view/detail%20post/widgets/blog_content.dart';
import 'package:tech_node/view/detail%20post/widgets/blog_hashtags.dart';
import 'package:tech_node/view/detail%20post/widgets/blog_thumbnail.dart';
import 'package:tech_node/view/detail%20post/widgets/blog_title.dart';

class DetailPostPage extends StatelessWidget {
  final String postId;
  const DetailPostPage({super.key, required this.postId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: background,
        elevation: 0,
        centerTitle: true,
        scrolledUnderElevation: 0.5,
        leading: IconButton(
          icon: const Icon(
            LucideIcons.arrowLeft,
            size: 22,
            color: Colors.white,
          ),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            }
          },
        ),
        actions: [
          IconButton(
            onPressed: () {},
            highlightColor: background,
            icon: const Icon(LucideIcons.share, color: Colors.white),
          ),
          IconButton(
            onPressed: () {},
            highlightColor: background,
            icon: const Icon(LucideIcons.bookmark, color: Colors.white),
          ),
        ],
        title: CustomTextStyle(
          text: '$postId Learn Flutter and  Laravel API with Habtemariam',
          fontWeight: FontWeight.w800,
          fontSize: 18,
          maxLine: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: const CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: BlogThumbnail()),
          SliverToBoxAdapter(child: BlogTitle()),
          SliverToBoxAdapter(child: AuthorProfile()),
          SliverToBoxAdapter(child: BlogContent()),
          SliverToBoxAdapter(child: BlogHashtags()),
        ],
      ),
    );
  }
}
