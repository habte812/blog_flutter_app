import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:tech_node/core/constants/themes.dart';

class QuillEditorConfigration extends StatelessWidget {
  final QuillController controller;
  final String? hintText;
  final bool? scrollable;
  final bool? showCursor;
  final bool? expands;
  const QuillEditorConfigration({
    super.key,
    required this.controller,
    this.hintText,
    this.scrollable,
    this.showCursor,
    this.expands,
  });

  @override
  Widget build(BuildContext context) {
    return QuillEditor.basic(
      controller: controller,

      config: QuillEditorConfig(
        scrollable: scrollable ?? true,
        showCursor: showCursor ?? true,
        placeholder: hintText,
        expands: expands ?? true,
        customStyles: DefaultStyles(
          paragraph: const DefaultTextBlockStyle(
            TextStyle(color: Colors.white, fontSize: 16, height: 1.5),
            HorizontalSpacing(0, 0),
            VerticalSpacing(8, 0),
            VerticalSpacing(0, 0),
            null,
          ),
          link:  TextStyle(
            color: context.primary,
            decoration: TextDecoration.underline,
            fontWeight: FontWeight.w600,
          ),

          h1: const DefaultTextBlockStyle(
            TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
            HorizontalSpacing(0, 0),
            VerticalSpacing(16, 8),
            VerticalSpacing(0, 0),
            null,
          ),
          lists: const DefaultListBlockStyle(
            TextStyle(color: Colors.white, fontSize: 16),
            HorizontalSpacing(0, 0),
            VerticalSpacing(16, 8),
            VerticalSpacing(0, 0),
            null,
            null,
          ),
          code: DefaultTextBlockStyle(
            TextStyle(
              color: Colors.white.withValues(alpha: 0.9),
              fontSize: 14,
              height: 1.4,
              backgroundColor: Colors.transparent,
            ),
            const HorizontalSpacing(0, 0),
            const VerticalSpacing(12, 12),
            const VerticalSpacing(0, 0),
            BoxDecoration(
              color: Colors.white.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.white12),
            ),
          ),
          leading: const DefaultTextBlockStyle(
            TextStyle(color: Colors.white),
            HorizontalSpacing(0, 0),
            VerticalSpacing(0, 0),
            VerticalSpacing(0, 0),
            null,
          ),
          quote: DefaultTextBlockStyle(
            const TextStyle(color: Colors.white70, fontStyle: FontStyle.italic),
            const HorizontalSpacing(0, 0),
            const VerticalSpacing(10, 10),
            const VerticalSpacing(0, 0),
            BoxDecoration(
              border:  Border(
                left: BorderSide(color: context.primary, width: 4),
              ),
              color: Colors.white.withValues(alpha: 0.05),
            ),
          ),
        ),
        scrollPhysics: const BouncingScrollPhysics(),
        textSelectionThemeData: TextSelectionThemeData(
          cursorColor: Colors.white,
          selectionColor: Colors.white70.withValues(alpha: 0.3),
        ),
        padding: EdgeInsets.zero,
      ),
    );
  }
}
