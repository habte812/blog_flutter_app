import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:tech_node/core/constants/themes.dart';
import 'package:tech_node/core/custom/custom_loading.dart';
import 'package:tech_node/core/custom/custom_text_style.dart';
import 'package:tech_node/data/viewModel/category/categories_notifier.dart';
import 'package:tech_node/data/viewModel/ui/ui%20blog%20data/ui_data_provider.dart';

class CategoryContainer extends ConsumerWidget {
  const CategoryContainer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCategory = ref.watch(
      uiDataProviderProvider.select((cat) => cat.blogCategory),
    );
    final categories = ref.watch(categoriesProvider);
    return categories.when(
      loading: () =>
          const Padding(padding: .all(16.0), child: CustomLineLoading()),
      error: (error, _) => categories.isLoading
          ? const Padding(padding: .all(16.0), child: CustomLineLoading())
          : Padding(
              padding: const .all(16.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: CustomTextStyle(
                      text: error.toString(),
                      fontSize: 14,
                      textColor: Colors.red,
                      maxLine: 2,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () async => ref.invalidate(categoriesProvider),
                    icon: Icon(LucideIcons.refreshCcw, color: context.primary),
                  ),
                ],
              ),
            ),
      data: (categoryList) {
        if (categoryList.isEmpty) {
          return const CustomTextStyle(text: "No categories yet", fontSize: 14);
        }
        final String? currentValue =
            categoryList.any((c) => c.name == selectedCategory)
            ? selectedCategory
            : null;
        return Padding(
          padding: const .all(16),
          child: DropdownButtonFormField<String>(
            initialValue: currentValue,
            dropdownColor: const Color(0xff1d2228),
            icon: const Icon(Icons.arrow_drop_down, color: Colors.white54),
            style: const TextStyle(color: Colors.white, fontSize: 16),
            decoration: InputDecoration(
              labelText: "Select Category*",
              labelStyle: const TextStyle(color: Colors.white54),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white10),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: context.primary),
              ),
            ),
            items: categoryList.map((category) {
              return DropdownMenuItem<String>(
                value: category.id.toString(),
                child: CustomTextStyle(text: category.name, fontSize: 14),
              );
            }).toList(),
            onChanged: (String? newValue) {
              if (newValue != null) {
                ref
                    .read(uiDataProviderProvider.notifier)
                    .updateBlogCategory(newValue);
              }
            },
          ),
        );
      },
    );
  }
}
