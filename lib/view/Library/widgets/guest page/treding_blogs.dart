import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:tech_node/core/constants/themes.dart';
import 'package:tech_node/core/custom/custom_loading.dart';
import 'package:tech_node/core/custom/custom_text_style.dart';

class TredingBlogs extends StatelessWidget {
  const TredingBlogs({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 3,
      itemBuilder: (context, index) {
        return const SavedTredingCard();
      },
    );
  }
}

class SavedTredingCard extends StatelessWidget {
  const SavedTredingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: card,
        highlightColor: card,
        onTap: () {},
        child: Container(
          height: 144,
          margin: const .only(left: 16, right: 16, top: 5, bottom: 10),
          padding: const .all(12),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: ClipRRect(
                  borderRadius: .circular(6),
                  child: CachedNetworkImage(
                    height: 138,
                    width: 138,
                    fit: BoxFit.cover,
                    imageUrl:
                        'https://www.mamp.one/wp-content/uploads/2024/09/image-resources2.jpg',
                    placeholder: (context, url) =>
                        const Center(child: CustomLoading()),
                    errorWidget: (context, url, error) => const Center(
                      child: Icon(
                        LucideIcons.imageOff,
                        color: Colors.redAccent,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                flex: 6,
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    Container(
                      padding: const .symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        color: Colors.white70.withValues(alpha: 0.06),
                        borderRadius: .circular(6),
                      ),
                      child: CustomTextStyle(
                        text: 'Programming',
                        fontSize: 11,
                        textColor: context.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const CustomTextStyle(
                      text: 'Flutter and Laravel Development',
                      fontSize: 16,
                      maxLine: 2,
                      overflow: TextOverflow.ellipsis,
                      fontWeight: FontWeight.bold,
                    ),
                    const Spacer(),
                    // CommonAuthorProfile(radius: 10, blogModel: blogModel),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
