import 'package:flutter/material.dart';
import 'package:tech_node/core/constants/themes.dart';
import 'package:tech_node/core/custom/custom_text_style.dart';
import 'package:tech_node/view/create/widgets/guest/section_label.dart';

class FeaturesGrid extends StatelessWidget {
  const FeaturesGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final features = [
      const Feature(
        icon: Icons.text_fields_rounded,
        label: 'Rich Editor',
        desc: 'Bold, italic, headings, lists, code blocks & more',
        color: Color.fromRGBO(99, 102, 241, 1),
      ),
      const Feature(
        icon: Icons.image_outlined,
        label: 'Cover Images',
        desc: 'Beautiful headers that capture readers instantly',
        color: Color.fromRGBO(244, 63, 94, 1),
      ),
      const Feature(
        icon: Icons.label_outline_rounded,
        label: 'Smart Tags',
        desc: 'Reach readers who care about your topics',
        color: Color.fromRGBO(245, 158, 11, 1),
      ),
      const Feature(
        icon: Icons.drafts_outlined,
        label: 'Auto-Save Drafts',
        desc: 'Your ideas are never lost — ever',
        color: Color.fromARGB(255, 34, 197, 94),
      ),
      const Feature(
        icon: Icons.public_rounded,
        label: 'Instant Publish',
        desc: 'Go live in one tap to thousands of readers',
        color: Color.fromARGB(255, 0, 201, 167),
      ),
      const Feature(
        icon: Icons.edit_note,
        label: 'Easy to use Editor',
        desc: 'Write and edit your blog posts with ease',
        color: Color.fromRGBO(99, 102, 241, 1),
      ),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionLabel(label: 'Everything you get'),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: features.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.55,
            ),
            itemBuilder: (_, i) => FeatureCard(feature: features[i]),
          ),
        ),
      ],
    );
  }
}

class Feature {
  final IconData icon;
  final String label;
  final String desc;
  final Color color;
  const Feature({
    required this.icon,
    required this.label,
    required this.desc,
    required this.color,
  });
}

class FeatureCard extends StatelessWidget {
  final Feature feature;
  const FeatureCard({super.key, required this.feature});

  @override
  Widget build(BuildContext context) => Container(
    padding: const .symmetric(vertical: 12, horizontal: 14),
    decoration: BoxDecoration(
      color: card,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: const Color.fromARGB(255, 39, 42, 54)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: feature.color.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(9),
          ),
          child: Icon(feature.icon, size: 16, color: feature.color),
        ),
        const SizedBox(height: 10),
        CustomTextStyle(
          text: feature.label,
          fontSize: 13,
          fontWeight: FontWeight.w700,
        ),
        const SizedBox(height: 3),
        Expanded(
          child: CustomTextStyle(
            text: feature.desc,
            maxLine: 2,
            overflow: TextOverflow.ellipsis,
            fontSize: 12,
            textColor: const Color.fromARGB(255, 138, 143, 168),
          ),
        ),
      ],
    ),
  );
}
