import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tech_node/core/custom/custom_text_field.dart';
import 'package:tech_node/data/viewModel/ui/ui%20blog%20data/ui_data_provider.dart';

class TitleContainer extends ConsumerWidget {
  const TitleContainer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final titleController = ref
        .read(uiDataProviderProvider.notifier)
        .blogtitleController;
    return Padding(
      padding: const .all(16),
      child: CustomTextField(
        controller: titleController,
        label: 'Title*',
        contentPadding: const .symmetric(horizontal: 10, vertical: 5),
        hintText: 'Write your title',
        fontWeight: FontWeight.bold,
        textStyle: const TextStyle(
          fontSize: 20,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
