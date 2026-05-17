import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:tech_node/core/constants/themes.dart';
import 'package:tech_node/view/profile/widgets/blog/draft_blogs.dart';
import 'package:tech_node/view/profile/widgets/blog/my_posted_blogs.dart';

class BlogsBar extends StatelessWidget {
  const BlogsBar({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              actions: null,
              leading: null,
              pinned: true,
              toolbarHeight: 15,
              elevation: 0,
              forceElevated: innerBoxIsScrolled,
              backgroundColor: background,
              surfaceTintColor: background,
              bottom:  TabBar(
                dividerColor: Colors.transparent,
                labelColor: context.primary,
                unselectedLabelColor: Colors.white60,
                indicatorColor: Colors.white60,
                labelPadding: const .symmetric(vertical: 8),
                tabs: [const Icon(Icons.drafts_outlined), const Icon(LucideIcons.send)],
              ),
            ),
          ];
        },
        body: const TabBarView(children: [DraftBlogs(), MyPostedBlogs()]),
      ),
    );
  }
}
