import 'package:flutter/material.dart';
import 'package:tech_node/core/custom/custom_text_style.dart';

class CategoryContainer extends StatelessWidget {
  const CategoryContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> categories = [
      'Technology',
      'Programming',
      'Design',
      'Engineering',
      'Lifestyle',
      'Other',
    ];
    return Padding(
      padding: const .all(16),
      child: DropdownButtonFormField<String>(
        dropdownColor: const Color(0xff1d2228),
        icon: const Icon(Icons.arrow_drop_down, color: Colors.white54),
        style: const TextStyle(color: Colors.white, fontSize: 16),
        decoration: const InputDecoration(
          labelText: "Select Category",
          labelStyle: TextStyle(color: Colors.white54),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white10),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
          ),
        ),
        items: categories.map((String category) {
          return DropdownMenuItem<String>(
            value: category,
            child: CustomTextStyle(text: category, fontSize: 14),
          );
        }).toList(),
        onChanged: (String? newValue) {},
      ),
    );
  }
}
