import 'package:flutter/material.dart';
import 'package:tech_node/core/custom/custom_text_style.dart';
import 'package:tech_node/view/Library/widgets/guest%20page/saved_empty_state.dart';
import 'package:tech_node/view/Library/widgets/guest%20page/treding_blogs.dart';

class FavoritesGuestPage extends StatelessWidget {
  const FavoritesGuestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      strokeWidth: 2.5,
      onRefresh: () async {},
      child: CustomScrollView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SavedEmptyState(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 4, 20, 20),
                  child: Row(
                    children: [
                      CustomTextStyle(
                        text: 'Trending right now'.toUpperCase(),
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.8,
                        textColor: Colors.white54,
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Divider(color: Colors.white54, height: 1),
                      ),
                    ],
                  ),
                ),
                const TredingBlogs(),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
