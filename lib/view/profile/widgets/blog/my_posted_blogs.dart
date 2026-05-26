import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tech_node/core/commen/feeds_list_card.dart';
import 'package:tech_node/core/custom/custom_bottom_loader.dart';
import 'package:tech_node/core/custom/custom_empty_state.dart';
import 'package:tech_node/core/custom/custom_error_notifier.dart';
import 'package:tech_node/core/custom/custom_shimmer_loading.dart';
import 'package:tech_node/data/viewModel/blog/my%20posted%20blogs/my_posted_blogs_notifier.dart';
import 'package:tech_node/view/Library/widgets/saved_blogs_list.dart';

class MyPostedBlogs extends ConsumerWidget {
  const MyPostedBlogs({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Consumer(
      builder: (context, ref, child) {
        final state = ref.watch(myPostedBlogsProvider);
        if (state.isLoading && state.myblogs.isEmpty) {
          return ListView.builder(
            itemCount: 6,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return const FeedsListCardShimmer();
            },
          );
        }
        if (state.isFailure && state.myblogs.isEmpty) {
          return CustomErrorNotifier(
            errorMessage: state.errorMessage ?? 'Something went wrong.',
            action: () =>
                ref.read(myPostedBlogsProvider.notifier).fetchFirstPage(),
          );
        }
        if (!state.isLoading && state.myblogs.isEmpty) {
          Padding(
            padding: .only(top: MediaQuery.of(context).size.height * 0.12),
            child: const CustomEmptyState(
              description:
                  "You haven't posted any blogs yet. Start sharing your knowledge and ideas with the community!",
              title: "No posts yet",
              icon: Icons.create_new_folder_outlined,
            ),
          );
        }
        return Column(
          
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: state.myblogs.length,
              itemBuilder: (context, index) {
                if (index >= state.myblogs.length) return null;
                return FeedsListCard(blogModel: state.myblogs[index]);
              },
            ),

            if (state.errorMessage != null &&
                state.myblogs.isNotEmpty &&
                !state.isLoadingMore)
              InlineErrorBanner(
                message: state.errorMessage!,
                onRetry: () =>
                    ref.read(myPostedBlogsProvider.notifier).fetchMorePosts(),
              ),
            CustomBottomLoader(
              isLoadingMore: state.isLoadingMore,
              hasMorePages: state.hasMorePages,
              endTitle: 'You\'ve got all blogs',
              isEmpty: state.myblogs.isEmpty,
            ),
          ],
        );
      },
    );
  }
}
