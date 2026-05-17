import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:tech_node/core/constants/themes.dart';
import 'package:tech_node/core/custom/custom_text_style.dart';
import 'package:tech_node/view/followings/widgets/guest/authors_card.dart';

class FeaturedAuthors extends StatelessWidget {
  const FeaturedAuthors({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        Padding(
          padding: const .symmetric(horizontal: 16),
          child: Row(
            children: [
              const Icon(LucideIcons.users, size: 18),
              const SizedBox(width: 8),
              const CustomTextStyle(
                text: 'Discover Authors',
                fontSize: 17,
                fontWeight: .bold,
                letterSpacing: -0.3,
              ),
              const Spacer(),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(0, 32),
                ),
                child: Row(
                  children: [
                    CustomTextStyle(
                      text: 'See all',
                      fontSize: 13,
                      textColor: context.primary,
                    ),
                    const SizedBox(width: 2),
                    Icon(
                      LucideIcons.arrowRight,
                      size: 13,
                      color: context.primary,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // const SizedBox(height: 6),
        // const Padding(
        //   padding: EdgeInsets.only(left: 16),
        //   child: CustomTextStyle(text: 'Authors you might love', fontSize: 13),
        // ),
        const SizedBox(height: 16),
        SizedBox(
          height: 210,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 16, right: 16),
            itemCount: 4,
            separatorBuilder: (_, _) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              return const AuthorsCard();
            },
          ),
        ),
      ],
    );
  }
}
