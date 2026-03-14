import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:tech_node/core/constants/themes.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:tech_node/core/custom/custom_text_style.dart';

class ContentContainer extends HookWidget {
  const ContentContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = useMemoized(() => QuillController.basic());
    return Column(
      crossAxisAlignment: .start,
      children: [
        Padding(
          padding: const .only(left: 16.0),
          child: CustomTextStyle(
            text: 'Content',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          height: 400,
          margin: const .all(16),
          decoration: BoxDecoration(
            color: card,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.white24),
          ),
          child: Column(
            children: [
              Container(
                padding: const .symmetric(vertical: 4),
                decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.white24)),
                  color: Color(0xff151A1F),
                  borderRadius: BorderRadius.only(
                    topLeft: .circular(10),
                    topRight: .circular(10),
                  ),
                ),
                child: QuillSimpleToolbar(
                  controller: controller,
                  config: QuillSimpleToolbarConfig(
                    toolbarIconAlignment: .start,
                    toolbarSectionSpacing: 0,
                    toolbarRunSpacing: 0,
                    sectionDividerSpace: 0,
                    showDividers: false,
                    axis: .horizontal,
                    showBoldButton: true,
                    showQuote: true,
                    showIndent: true,
                    showItalicButton: true,
                    showUnderLineButton: true,
                    showHeaderStyle: true,
                    showStrikeThrough: true,
                    showListBullets: true,
                    showLink: true,
                    showAlignmentButtons: true,
                    showColorButton: false,
                    showBackgroundColorButton: false,
                    showSearchButton: false,
                    showListCheck: false,
                    showFontFamily: false,
                    showSubscript: false,
                    showSuperscript: false,
                    showFontSize: false,
                    showUndo: false,
                    showRedo: false,
                    showClearFormat: false,
                    showInlineCode: false,
                    showListNumbers: false,
                    buttonOptions: QuillSimpleToolbarButtonOptions(
                      base: QuillToolbarBaseButtonOptions(
                        iconTheme: QuillIconTheme(
                          iconButtonUnselectedData: IconButtonData(
                            color: Colors.white70,
                          ),
                          iconButtonSelectedData: IconButtonData(
                            color: Colors.white,
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all(primary),
                            ),
                          ),
                        ),
                      ),
                      selectHeaderStyleDropdownButton:
                          QuillToolbarSelectHeaderStyleDropdownButtonOptions(
                            textStyle: TextStyle(color: Colors.white),
                          ),
                    ),
                  ),
                ),
              ),

              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: QuillEditor.basic(
                    controller: controller,
                    config: QuillEditorConfig(
                      placeholder: "Start writing here...",
                      expands: true,
                      customStyles: DefaultStyles(
                        paragraph: DefaultTextBlockStyle(
                          const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            height: 1.5,
                          ),
                          const HorizontalSpacing(0, 0),
                          const VerticalSpacing(8, 0),
                          const VerticalSpacing(0, 0),
                          null,
                        ),
                        link: const TextStyle(
                          color: primary,
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.w600,
                        ),

                        h1: DefaultTextBlockStyle(
                          const TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                          const HorizontalSpacing(0, 0),
                          const VerticalSpacing(16, 8),
                          const VerticalSpacing(0, 0),
                          null,
                        ),
                        lists: DefaultListBlockStyle(
                          const TextStyle(color: Colors.white, fontSize: 16),
                          const HorizontalSpacing(0, 0),
                          const VerticalSpacing(16, 8),
                          const VerticalSpacing(0, 0),
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
                        leading: DefaultTextBlockStyle(
                          const TextStyle(color: Colors.white),
                          const HorizontalSpacing(0, 0),
                          const VerticalSpacing(0, 0),
                          const VerticalSpacing(0, 0),
                          null,
                        ),
                        quote: DefaultTextBlockStyle(
                          const TextStyle(
                            color: Colors.white70,
                            fontStyle: FontStyle.italic,
                          ),
                          const HorizontalSpacing(0, 0),
                          const VerticalSpacing(10, 10),
                          const VerticalSpacing(0, 0),
                          BoxDecoration(
                            border: const Border(
                              left: BorderSide(color: primary, width: 4),
                            ),
                            color: Colors.white.withValues(alpha: 0.05),
                          ),
                        ),
                      ),
                      scrollPhysics: BouncingScrollPhysics(),
                      textSelectionThemeData: TextSelectionThemeData(
                        cursorColor: Colors.white,
                        selectionColor: Colors.white70.withValues(alpha: 0.3),
                      ),
                      padding: EdgeInsets.zero,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
