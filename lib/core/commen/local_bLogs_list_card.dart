import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tech_node/core/constants/themes.dart';
import 'package:tech_node/core/custom/custom_text_style.dart';
import 'package:tech_node/data%20local/local%20Models/offline_blogs_model.dart';

class LocalBLogsListPage extends StatelessWidget {
  final OfflineBlogsModel theModel;
  final bool isSaved;
  const LocalBLogsListPage({
    super.key,
    required this.isSaved,
    required this.theModel,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: card,
        highlightColor: card,
        onTap: () {
          if (!context.mounted) return;
          context.push('/offline_detail/${theModel.id}');
        },
        child: Container(
          height: 144,
          margin: const .only(left: 16, right: 16, top: 5, bottom: 10),
          padding: const .all(12),
          child: Row(
            children: [
              if (theModel.thumbnail != null)
                Expanded(
                  flex: 3,
                  child: ClipRRect(
                    borderRadius: .circular(6),
                    child: Hero(
                      tag: '${theModel.id}image',
                      child: Image.file(
                        File(theModel.thumbnail!),
                        height: 138,
                        width: 138,
                        fit: .cover,
                      ),
                    ),
                  ),
                ),
              const SizedBox(width: 16),
              Expanded(
                flex: 6,
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    Row(
                      mainAxisAlignment: .spaceBetween,
                      children: [
                        Container(
                          padding: const .symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                            color: Colors.white70.withValues(alpha: 0.06),
                            borderRadius: .circular(6),
                          ),
                          child: CustomTextStyle(
                            text: theModel.categoryName,
                            fontSize: 11,
                            textColor: context.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (isSaved)
                          Icon(Icons.bookmark, color: context.primary),
                      ],
                    ),
                    const SizedBox(height: 6),
                    CustomTextStyle(
                      text: theModel.title,
                      fontSize: 16,
                      maxLine: 2,
                      overflow: TextOverflow.ellipsis,
                      fontWeight: FontWeight.bold,
                    ),

                    CustomTextStyle(
                      text:
                          "By ${theModel.authorName} • ${theModel.publishedAt}",
                      fontSize: 12,
                      maxLine: 2,
                      textColor: Colors.white70,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
