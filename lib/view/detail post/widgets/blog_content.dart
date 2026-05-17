import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:tech_node/data/model/blog/blogs_detail_model.dart';
import 'package:tech_node/view/create/widgets/blog%20content/quill_editor_configration.dart';

class BlogContent extends StatelessWidget {
  final BlogsDetailModel blogDetail;
  const BlogContent({super.key, required this.blogDetail});

  @override
  Widget build(BuildContext context) {
    final theDoc = Document.fromJson(jsonDecode(blogDetail.content));
    final theContent = QuillController(
      document: theDoc,
      selection: const TextSelection.collapsed(offset: 0),
      readOnly: true,
    );
    return Padding(
      padding: const .all(16.0),
      child: QuillEditorConfigration(
        controller: theContent,
        scrollable: false,
        showCursor: false,
        expands: false,
      ),
    );
  }
}
