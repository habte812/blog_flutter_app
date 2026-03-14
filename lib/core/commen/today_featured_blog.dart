import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tech_node/core/commen/widgets/author_profile.dart';
import 'package:tech_node/core/custom/custom_text_style.dart';

class TodayFeaturedBlog extends StatelessWidget {
  const TodayFeaturedBlog({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!context.mounted) return;
        context.push('/detail_page/134');
      },
      child: SizedBox(
        width: 360,
        child: Padding(
          padding: const .all(16),
          child: Column(
            crossAxisAlignment: .start,
            children: [
              AspectRatio(
                aspectRatio: 16 / 9,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: const DecorationImage(
                      image: AssetImage('assets/images/im5.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              const CustomTextStyle(
                text: 'Learn Flutter and Laravel API with Habtemariam',
                fontSize: 18,
                maxLine: 2,
                overflow: TextOverflow.ellipsis,
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(height: 8),
              const CustomTextStyle(
                text:
                    'Learn Flutter and Laravel API with Habtemariam Learn Flutter and Laravel API with HabtemariamLearn Flutter and Laravel API with Habtemariam',
                fontSize: 14,
                maxLine: 2,
                overflow: TextOverflow.ellipsis,
                textColor: Colors.white60,
              ),
              const SizedBox(height: 9),
              const AuthorProfile(radius: 16),
            ],
          ),
        ),
      ),
    );
  }
}
