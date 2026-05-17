import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:tech_node/view/home/widgets/explore/widgets/recent_search_history.dart';

class ExploreSearchBar extends HookWidget {
  final bool isSearching;
  final VoidCallback onTap;
  final VoidCallback onClose;

  const ExploreSearchBar({
    super.key,
    required this.isSearching,
    required this.onTap,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    final controller = useSearchController();

    return SearchAnchor(
      searchController: controller,
      isFullScreen: false,
      viewBackgroundColor: const Color(0xff1c2733),
      viewElevation: 10,
      viewConstraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.6,
      ),
      viewShape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      builder: (context, controller) {
        return Padding(
          padding: const .only(bottom: 5.0),
          child: SearchBar(
            leading: const Icon(Icons.search, color: Colors.white38),
            readOnly: true,
            controller: controller,
            onTap: () async {
              onTap();
              await Future.delayed(const Duration(milliseconds: 305));
              controller.openView();
            },
            trailing: [
              if (isSearching)
                IconButton(
                  onPressed: () {
                    controller.clear();
                    if (controller.isOpen) {
                      controller.closeView(null);
                    }
                    onClose();
                    FocusScope.of(context).unfocus();
                  },
                  icon: const Icon(
                    Icons.close,
                    size: 18,
                    color: Colors.white38,
                  ),
                ),
            ],
            hintText: 'Search blogs, authors...',
            hintStyle: const WidgetStatePropertyAll(
              TextStyle(color: Colors.white54),
            ),
            backgroundColor: const WidgetStatePropertyAll(Color(0xff1c2733)),
            elevation: const WidgetStatePropertyAll(0),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
        );
      },
      suggestionsBuilder: (context, controller) {
        return [RecentSearchHistory(controller: controller)];
      },
    );
  }
}
