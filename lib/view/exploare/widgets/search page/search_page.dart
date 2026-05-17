import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:tech_node/core/constants/themes.dart';
import 'package:tech_node/core/custom/custom_text_style.dart';

class SearchPage extends HookWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = useSearchController();

    // Auto-expand the search view when entering the page
    useEffect(() {
      Future.delayed(const Duration(milliseconds: 50), () {
        controller.openView();
      });
      return null;
    }, []);

    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SearchAnchor(
            searchController: controller,
            viewBackgroundColor: background,
            viewElevation: 0,
            viewShape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
            ),
            builder: (context, controller) {
              return Hero(
                tag: 'search_morph',
                child: Material(
                  color: Colors.transparent,
                  child: SearchBar(
                    controller: controller,
                    onTap: () => controller.openView(),
                    onChanged: (_) => controller.openView(),
                    hintText: 'Search blogs, authors...',
                    hintStyle: WidgetStateProperty.all(
                      const TextStyle(color: Colors.white38, fontSize: 14),
                    ),
                    leading: const Icon(
                      LucideIcons.search,
                      color: Colors.white38,
                      size: 20,
                    ),
                    backgroundColor: const WidgetStatePropertyAll(background),
                    elevation: const WidgetStatePropertyAll(0),
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              );
            },
            suggestionsBuilder: (context, controller) {
              // DEMO DATA: Recent Searches & Trending
              final items = [
                'Flutter Glassmorphism',
                'Laravel 11 API',
                'Ethiopian Tech',
                'Deep Learning',
              ];

              return [
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
                  child: CustomTextStyle(
                    text: "Recent Searches",
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                ...items.map(
                  (item) => ListTile(
                    leading: const Icon(
                      LucideIcons.history,
                      color: Colors.white24,
                      size: 18,
                    ),
                    title: CustomTextStyle(
                      text: item,
                      textColor: Colors.white70,
                      fontSize: 14,
                    ),
                    trailing: const Icon(
                      LucideIcons.arrowUpLeft,
                      color: Colors.white24,
                      size: 18,
                    ),
                    onTap: () => controller.text = item,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
                  child: CustomTextStyle(
                    text: "Trending Categories",
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Wrap(
                    spacing: 10,
                    children: ['Technology', 'Lifestyle', 'Coding', 'Health']
                        .map(
                          (tag) => ActionChip(
                            label: CustomTextStyle(text: tag, fontSize: 12),
                            backgroundColor: const Color(0xff1c2733),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            onPressed: () {},
                          ),
                        )
                        .toList(),
                  ),
                ),
              ];
            },
          ),
        ),
      ),
    );
  }
}

// class SearchPage extends HookWidget {
//   const SearchPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final focusNode = useFocusNode();

//     useEffect(() {
//       // Small delay to let the Hero animation finish before popping keyboard
//       Future.delayed(const Duration(milliseconds: 350), () {
//         focusNode.requestFocus();
//       });
//       return null;
//     }, []);

//     return Scaffold(
//       backgroundColor: background,
//       body: SafeArea(
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Hero(
//                 tag: 'search_morph', // Must match!
//                 child: Material(
//                   color: Colors.transparent,
//                   child: TextField(
//                     focusNode: focusNode,
//                     style: const TextStyle(color: Colors.white),
//                     decoration: InputDecoration(
//                       hintText: "Type to search...",
//                       prefixIcon: const Icon(LucideIcons.search, size: 20),
//                       // This pulls your PL theme settings automatically
//                       suffixIcon: IconButton(
//                         icon: const Icon(Icons.close, size: 18),
//                         onPressed: () => context.pop(),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             // Results go here
//             Expanded(
//               child: Container(color: Colors.amber, height: 50, width: 50),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
