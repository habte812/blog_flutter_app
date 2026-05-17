import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tech_node/core/constants/themes.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:tech_node/core/custom/custom_text_style.dart';
import 'package:tech_node/data/viewModel/ui/ui%20blog%20data/ui_data_provider.dart';
import 'package:tech_node/view/create/widgets/blog%20content/quill_editor_configration.dart';

class ContentContainer extends StatelessWidget {
  const ContentContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        const Padding(
          padding: .only(left: 16.0),
          child: CustomTextStyle(
            text: 'Content*',
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
                child: Consumer(
                  builder: (context, ref, child) {
                    final controller = ref
                        .read(uiDataProviderProvider.notifier)
                        .blogContentController;
                    return QuillSimpleToolbar(
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
                              iconButtonUnselectedData: const IconButtonData(
                                color: Colors.white70,
                              ),
                              iconButtonSelectedData: IconButtonData(
                                color: Colors.white,
                                style: ButtonStyle(
                                  backgroundColor: WidgetStateProperty.all(
                                    context.primary,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          selectHeaderStyleDropdownButton:
                              const QuillToolbarSelectHeaderStyleDropdownButtonOptions(
                                textStyle: TextStyle(color: Colors.white),
                              ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Consumer(
                    builder: (context, ref, child) {
                      final controller = ref
                          .read(uiDataProviderProvider.notifier)
                          .blogContentController;
                      return QuillEditorConfigration(
                        controller: controller,
                        hintText: "Start writing here...",
                      );
                    },
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
