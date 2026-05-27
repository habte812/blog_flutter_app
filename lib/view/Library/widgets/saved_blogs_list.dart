import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tech_node/core/commen/feeds_list_card.dart';
import 'package:tech_node/core/custom/custom_bottom_loader.dart';
import 'package:tech_node/core/custom/custom_empty_state.dart';
import 'package:tech_node/core/custom/custom_error_notifier.dart';
import 'package:tech_node/core/custom/custom_shimmer_loading.dart';
import 'package:tech_node/data/model/auth/auth_state.dart';
import 'package:tech_node/data/viewModel/auth/auth_notifier.dart';
import 'package:tech_node/data/viewModel/saved%20blogs/save_blog_notifier.dart';
import 'package:tech_node/view/Library/widgets/guest%20page/favorites_guest_page.dart';

class SavedBlogsList extends ConsumerWidget {
  const SavedBlogsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider).status;

    if (authState == AuthStatus.unauthenticated) {
      return const FavoritesGuestPage();
    } else if (authState == AuthStatus.error) {
      return const FavoritesGuestPage();
    } else if (authState == AuthStatus.loading) {
      return const FavoritesGuestPage();
    } 
    return Consumer(
      builder: (context, ref, child) {
        final state = ref.watch(mySavedBlogsProvider);

        if (state.isLoading && state.savedblogs.isEmpty) {
          return ListView.builder(
            itemCount: 5,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return const FeedsListCardShimmer();
            },
          );
        }
        if (state.isFailure && state.savedblogs.isEmpty) {
          return CustomErrorNotifier(
            errorMessage: state.errorMessage ?? 'Something went wrong.',
            action: () =>
                ref.read(mySavedBlogsProvider.notifier).firstFetchSaved(),
          );
        }

        if (!state.isLoading && state.savedblogs.isEmpty) {
        return  Padding(
            padding: .only(top: MediaQuery.of(context).size.height * 0.12),
            child: const CustomEmptyState(
              description:
                  "Save your favorite articles, tutorials, and tech insights to revisit them anytime.",
              title: "No favorites yet",
              icon: Icons.bookmark_border_rounded,
            ),
          );
        }
        return Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: state.savedblogs.length,
              itemBuilder: (context, index) {
                if (index >= state.savedblogs.length) return null;
                return FeedsListCard(blogModel: state.savedblogs[index]);
              },
            ),
            if (state.errorMessage != null &&
                state.savedblogs.isNotEmpty &&
                !state.isLoadingMore)
              InlineErrorBanner(
                message: state.errorMessage!,
                onRetry: () =>
                    ref.read(mySavedBlogsProvider.notifier).fetchMoreSaveds(),
              ),
            CustomBottomLoader(
              isLoadingMore: state.isLoadingMore,
              hasMorePages: state.hasMorePages,
              endTitle: 'You\'ve got all blogs',
              isEmpty: state.savedblogs.isEmpty,
            ),
          ],
        );
      },
    );
  }
}

class InlineErrorBanner extends StatelessWidget {
  const InlineErrorBanner({
    super.key,
    required this.message,
    required this.onRetry,
  });
  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const .symmetric(horizontal: 16, vertical: 8),
      padding: const .symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFFF5757).withValues(alpha: 0.12),
        borderRadius: .circular(10),
        border: .all(color: const Color(0xFFFF5757).withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.error_outline_rounded,
            color: Color(0xFFFF5757),
            size: 18,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(color: Color(0xFFFF8A80), fontSize: 13),
            ),
          ),
          TextButton(
            onPressed: onRetry,
            style: TextButton.styleFrom(
              foregroundColor: const Color(0xFFFF5757),
              padding: const EdgeInsets.symmetric(horizontal: 8),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: const Text('Retry', style: TextStyle(fontSize: 13)),
          ),
        ],
      ),
    );
  }
}
