import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

class SuggestedSearches extends StatelessWidget {
  const SuggestedSearches({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => ListTile(
          leading: const Icon(LucideIcons.search, color: Colors.white38),
          onTap: () => context.pushNamed('search'),
          title: const Text(
            "What is Laravel sanctum?",
            style: TextStyle(color: Colors.white),
          ),
        ),
        childCount: 10,
      ),
    );
  }
}
