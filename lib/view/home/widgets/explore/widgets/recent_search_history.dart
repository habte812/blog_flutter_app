import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:tech_node/core/custom/custom_text_style.dart';

class RecentSearchHistory extends StatelessWidget {
  final SearchController controller;
  const RecentSearchHistory({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          const Divider(color: Colors.white10, height: 1),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 10),
              children: [
                _sectionLabel("Recent Searches"),
                _suggestionTile(controller, "Flutter State Management"),
                _suggestionTile(controller, "Django Ninja vs FastAPI"),
                const SizedBox(height: 20),
                _sectionLabel("Trending Now"),
                _buildTags(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
  Widget _sectionLabel(String label) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 8),
      child: CustomTextStyle(
        text: label,
        fontSize: 13,
        textColor: Colors.white38,
        fontWeight: FontWeight.bold,
      ),
    );
  }


    Widget _suggestionTile(SearchController controller, String text) {
    return ListTile(
      leading: const Icon(LucideIcons.history, size: 18, color: Colors.white24),
      title: CustomTextStyle(
        text: text,
        fontSize: 15,
        textColor: Colors.white70,
      ),
      onTap: () => controller.closeView(text),
    );
  }


    Widget _buildTags() {
    final tags = ['Mobile', 'Backend', 'AI', 'UI/UX', 'Cloud'];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        children: tags
            .map(
              (tag) => ActionChip(
                label: CustomTextStyle(text: tag, fontSize: 12),
                backgroundColor: const Color(0xff1c2733),
                side: BorderSide.none,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                onPressed: () {},
              ),
            )
            .toList(),
      ),
    );
  }