import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:tech_node/core/constants/themes.dart';
import 'package:tech_node/core/custom/custom_text_field.dart';
import 'package:tech_node/view/exploare/widgets/recent_searchs.dart';

class SearchPage extends HookWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final searchFocusNode = useFocusNode();
    useEffect(() {
      Future.delayed(const Duration(milliseconds: 200), () {
        searchFocusNode.requestFocus();
      });
      return null;
    }, []);
    return Scaffold(
      backgroundColor: background,
      appBar: null,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: .all(16),
              sliver: SliverToBoxAdapter(
                child: Row(
                  children: [
                    Expanded(
                      child: IconButton(
                        highlightColor: background,
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
                    ),
                    Expanded(
                      flex: 8,
                      child: CustomTextField(
                        autofocus: true,
                        prefixIcon: Icon(LucideIcons.search),
                        hintText: 'search here...',
                        contentPadding: .symmetric(horizontal: 8, vertical: 0),
                      ),
                    ),

                    Expanded(
                      child: IconButton(
                        highlightColor: background,
                        icon: const Icon(
                          LucideIcons.x,
                          size: 22,
                          color: Colors.white,
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),
            ),
            RecentSearchs(),
          ],
        ),
      ),
    );
  }
}
