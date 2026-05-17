import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tech_node/core/constants/themes.dart';
import 'package:tech_node/core/custom/custom_shimmer_loading.dart';
import 'package:tech_node/core/custom/custom_text_style.dart';
import 'package:tech_node/data/model/author/author_model.dart';
import 'package:tech_node/data/viewModel/blog/follow%20author/follow_notifier.dart';

class FollowingAppBar extends StatelessWidget {
  const FollowingAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      snap: true,
      expandedHeight: 153,
      collapsedHeight: 153,
      flexibleSpace: Column(
        crossAxisAlignment: .start,
        children: [
          const Padding(
            padding: .only(left: 12, top: 5),
            child: CustomTextStyle(
              text: "Following",
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Consumer(
            builder: (context, ref, child) {
              final authors = ref.watch(getFollowingsProvider);
              return authors.when(
                data: (authors) {
                  if (authors.isEmpty) {
                    return const SizedBox.shrink();
                  }
                  return SizedBox(
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: authors.length >= 10 ? 10 : authors.length,
                      itemBuilder: (context, index) => _AuthorAvatarItem(
                        index: index,
                        author: authors[index],
                      ),
                    ),
                  );
                },
                loading: () => const FollowingsListShimmer(),
                error: (error, stackTrace) =>
                    CustomTextStyle(text: error.toString()),
              );
            },
          ),
        ],
      ),
      backgroundColor: background,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
    );
  }
}

class _AuthorAvatarItem extends StatelessWidget {
  final int index;
  final AuthorModel author;
  const _AuthorAvatarItem({required this.index, required this.author});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: card,
        highlightColor: card,
        onTap: () {
          context.push('/author-profile/${author.id}/');
        },
        child: Container(
          width: 75,
          margin: const EdgeInsets.only(right: 12),
          child: index == 9
              ? Center(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    onPressed: () {},
                    child: const CustomTextStyle(text: "See all"),
                  ),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (author.profilePicture != null)
                      Container(
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Theme.of(context).primaryColor,
                            width: 2,
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(author.profilePicture!),
                        ),
                      ),
                    const SizedBox(height: 8),
                    CustomTextStyle(
                      text: author.name,
                      fontSize: 11,
                      maxLine: 1,
                      textColor: Colors.white70,
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
