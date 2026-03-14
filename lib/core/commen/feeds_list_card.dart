import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tech_node/core/commen/widgets/author_profile.dart';
import 'package:tech_node/core/custom/custom_text_style.dart';

class FeedsListCard extends StatelessWidget {
  const FeedsListCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/detail_page/120'),
      child: Container(
        height: 138,
        margin: const .only(left: 16, right: 16, top: 5, bottom: 10),
        padding: const .all(12),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  image: const DecorationImage(
                    image: AssetImage('assets/images/im5.jpg'),
                    fit: BoxFit.cover,
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
                    padding: .symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      color: Colors.white70.withValues(alpha: 0.06),
                      borderRadius: .circular(6),
                    ),
                    child: CustomTextStyle(
                      text: 'Flutter',
                      fontSize: 11,
                      textColor: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  CustomTextStyle(
                    text: 'Learn Flutter and Laravel API with Habtemariam',
                    fontSize: 16,
                    maxLine: 2,
                    overflow: TextOverflow.ellipsis,
                    fontWeight: FontWeight.bold,
                  ),
                  Spacer(),
                  AuthorProfile(radius: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
