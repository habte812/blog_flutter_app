import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:tech_node/core/constants/themes.dart';
import 'package:tech_node/core/custom/custom_button.dart';
import 'package:tech_node/core/custom/custom_text_style.dart';
import 'package:tech_node/view/create/widgets/category_container.dart';
import 'package:tech_node/view/create/widgets/create_hashtags.dart';
import 'package:tech_node/view/create/widgets/content_container.dart';
import 'package:tech_node/view/create/widgets/title_container.dart';
import 'package:tech_node/view/create/widgets/upload_thumbnail.dart';

class CreatePage extends StatelessWidget {
  const CreatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: background,
        elevation: 0,
        centerTitle: true,
        scrolledUnderElevation: 0.5,
        leading: IconButton(
          icon: const Icon(
            LucideIcons.arrowLeft,
            size: 22,
            color: Colors.white,
          ),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            }
          },
        ),
        title: const CustomTextStyle(
          text: 'Create Post',
          fontWeight: FontWeight.w800,
          fontSize: 18,
        ),
      ),
      body: const CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: UploadThumbnail()),
          SliverToBoxAdapter(child: TitleContainer()),
          SliverToBoxAdapter(child: CategoryContainer()),
          SliverToBoxAdapter(child: ContentContainer()),
          SliverToBoxAdapter(child: CreateHashtags()),
          SliverToBoxAdapter(child: SizedBox(height: 80)),
        ],
      ),
      bottomNavigationBar: Container(
        height: 70,
        color: card,
        padding: const .all(8),
        child: Row(
          children: [
            Expanded(
              child: CustomButton(
                backgroundColor: Colors.transparent,
                onPressed: () {},
                label: const CustomTextStyle(
                  text: 'Save Draft',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 5),
            Expanded(
              flex: 2,
              child: CustomButton(
                onPressed: () {},
                label: const CustomTextStyle(
                  text: 'Publish',
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
