import 'package:flutter/material.dart';
import 'package:tech_node/core/commen/feeds_list_card.dart';
import 'package:tech_node/core/custom/custom_text_style.dart';

class BlogFeedsLists extends StatelessWidget {
  const BlogFeedsLists({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: .start,
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              spacing: 25,
              children: [
                CustomTextStyle(
                  text: "For you",
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                CustomTextStyle(
                  text: "Latest",
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  textColor: Colors.white30,
                ),
                CustomTextStyle(
                  text: "Trending",
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  textColor: Colors.white30,
                ),
              ],
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: 20,
            itemBuilder: (context, index) {
              return const FeedsListCard();
            },
          ),
        ],
      ),
    );
  }
}
