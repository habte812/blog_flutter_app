import 'package:flutter/material.dart';
import 'package:tech_node/core/constants/themes.dart';
import 'package:tech_node/view/create/widgets/guest/gggggggggggg.dart';
import 'package:tech_node/view/create/widgets/guest/ututututu.dart';

class WriterStatsTeaser extends StatelessWidget {
  const WriterStatsTeaser({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionLabel(label: 'Join the community'),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: card,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: background),
          ),
          child: const Row(
            children: [
              StatPill(value: '48K+', label: 'Writers', color: C.teal),
              VertDivider(),
              StatPill(value: '1.2M', label: 'Stories', color: C.indigo),
              VertDivider(),
              StatPill(value: '8.4M', label: 'Readers', color: C.rose),
            ],
          ),
        ),
      ],
    );
  }
}