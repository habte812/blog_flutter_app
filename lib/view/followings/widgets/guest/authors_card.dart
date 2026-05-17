import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:tech_node/core/constants/themes.dart';
import 'package:tech_node/core/custom/custom_text_style.dart';

class AuthorsCard extends StatelessWidget {
  const AuthorsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: 148,
      decoration: BoxDecoration(
        color: card,
        borderRadius: BorderRadius.circular(18),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: .circular(30),
            child: CircleAvatar(
              radius: 30,
              backgroundColor: card,
              child: CachedNetworkImage(
                fit: .cover,
                imageUrl:
                    'https://www.mamp.one/wp-content/uploads/2024/09/image-resources2.jpg',
                placeholder: (context, url) => const Center(
                  child: Icon(
                    LucideIcons.user,
                    color: Colors.white54,
                    size: 45,
                  ),
                ),
                errorWidget: (context, url, error) => const Center(
                  child: Icon(
                    LucideIcons.user,
                    color: Colors.redAccent,
                    size: 45,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          const CustomTextStyle(
            text: "Habtemariam Melsie",
            textAlign: TextAlign.center,
            maxLine: 1,
            overflow: .ellipsis,

            fontSize: 13,
            fontWeight: .bold,
          ),

          const SizedBox(height: 2),
          const CustomTextStyle(
            text: 'my bio',
            textAlign: TextAlign.center,

            fontSize: 11,
          ),

          const SizedBox(height: 4),
          const CustomTextStyle(
            text: '2.4k followers',
            textAlign: TextAlign.center,

            fontSize: 10,
          ),

          const SizedBox(height: 12),

          SizedBox(
            width: double.infinity,
            height: 34,
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                foregroundColor: context.primary,
                side: BorderSide(color: context.primary, width: 1.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: .zero,
              ),
              child: const Row(
                mainAxisAlignment: .center,
                children: [
                  Icon(LucideIcons.plus, size: 13),
                  SizedBox(width: 4),
                  CustomTextStyle(
                    text: 'Follow',
                    fontSize: 12,
                    fontWeight: .w600,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
