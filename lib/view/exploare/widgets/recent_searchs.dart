import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RecentSearchs extends StatelessWidget {
  const RecentSearchs({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => ListTile(
          leading: const Icon(Icons.find_replace_outlined, color: Colors.white38),
          onTap: () => context.pushNamed('search'),
          title: const Text(
            "Recent searchs",
            style: TextStyle(color: Colors.white),
          ),
        ),
        childCount: 10,
      ),
    );
  }
}
