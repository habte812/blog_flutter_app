import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tech_node/core/commen/feeds_list_card.dart';
import 'package:tech_node/core/custom/custom_bottom_loader.dart';
import 'package:tech_node/core/custom/custom_empty_state.dart';
import 'package:tech_node/core/custom/custom_error_notifier.dart';
import 'package:tech_node/core/custom/custom_shimmer_loading.dart';
import 'package:tech_node/data/viewModel/blog/follow%20author/follow_notifier.dart';
import 'package:tech_node/view/Library/widgets/saved_blogs_list.dart';

class FollowingBlogsList extends ConsumerWidget {
  const FollowingBlogsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Consumer(
      builder: (context, ref, child) {
        final state = ref.watch(myFollowingBlogsProvider);

        if (state.isLoading && state.items.isEmpty) {
          return ListView.builder(
            itemCount: 5,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return const FeedsListCardShimmer();
            },
          );
        }
        if (state.isFailure && state.items.isEmpty) {
          return CustomErrorNotifier(
            errorMessage: state.errorMessage ?? 'Something went wrong.',
            action: () =>
                ref.read(myFollowingBlogsProvider.notifier).firstFetchSaved(),
          );
        }
        return Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: state.items.length,
              itemBuilder: (context, index) {
                if (index >= state.items.length) return null;
                return FeedsListCard(blogModel: state.items[index]);
              },
            ),
            if (!state.isLoading && state.items.isEmpty)
              const CustomEmptyState(
                title: "No blogs from your network yet",
                description:
                    "Start following authors to get updates on their latest blogs",
              ),
            if (state.errorMessage != null &&
                state.items.isNotEmpty &&
                !state.isLoadingMore)
              InlineErrorBanner(
                message: state.errorMessage!,
                onRetry: () => ref
                    .read(myFollowingBlogsProvider.notifier)
                    .fetchMoreSaveds(),
              ),
            CustomBottomLoader(
              isLoadingMore: state.isLoadingMore,
              hasMorePages: state.hasMorePages,
              endTitle: 'You\'ve got all blogs',
              isEmpty: state.items.isEmpty,
            ),
          ],
        );
      },
    );
  }
}
