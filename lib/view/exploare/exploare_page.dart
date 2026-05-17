// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:tech_node/app/scroll_provider.dart';
// import 'package:tech_node/core/constants/themes.dart';
// import 'package:tech_node/core/custom/custom_text_style.dart';
// import 'package:tech_node/data/viewModel/category/categories_notifier.dart';
// import 'package:tech_node/view/exploare/widgets/exploare_app_bar.dart';
// import 'package:tech_node/view/exploare/widgets/suggested_searches.dart';
// import 'package:tech_node/view/exploare/widgets/trending_categories.dart';

// class ExplorePage extends StatelessWidget {
//   const ExplorePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final controller = ScrollProvider.of(context).exploreController;
//     return Consumer(
//       builder: (context, ref, child) {
//         return RefreshIndicator(
//           color: context.primary,
//           onRefresh: () async {
//             await ref.read(categoriesProvider.notifier).refreshTheCategory();
//           },
//           child: CustomScrollView(
//             controller: controller,
//             slivers: [
//               const ExploareAppBar(),
//               const SliverToBoxAdapter(
//                 child: Padding(
//                   padding: EdgeInsets.all(16.0),
//                   child: Text(
//                     "Trending Categories",
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),

//               const TrendingCategories(),
//               const SliverToBoxAdapter(
//                 child: Padding(
//                   padding: EdgeInsets.all(16.0),
//                   child: CustomTextStyle(
//                     text: 'Suggested Searches',
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//               const SuggestedSearches(),
//               const SliverToBoxAdapter(child: SizedBox(height: 30)),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
