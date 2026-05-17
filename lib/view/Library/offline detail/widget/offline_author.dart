import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:tech_node/core/constants/themes.dart';
import 'package:tech_node/core/custom/custom_text_style.dart';

class OfflineAuthor extends StatelessWidget {
  final int id;
  final String name;
  final String? image;
  final String publishedAt;
  const OfflineAuthor({
    super.key,
    required this.id,
    required this.name,
    required this.image,
    required this.publishedAt,
  });

  @override
  Widget build(BuildContext context) {
    final bool isLocal = image!.startsWith('/');
    return Column(
      crossAxisAlignment: .start,
      mainAxisSize: .min,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: .center,
            children: [
                if (!isLocal)
                  CachedNetworkImage(
                    imageUrl: image!,
                    fit: .cover,
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                if (isLocal)
                  GestureDetector(
                    onTap: () => context.push('/author-profile/$id'),
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: card,
                      backgroundImage: image != null
                          ? FileImage(File(image!))
                          : null,
                      child: image == null
                          ? const Icon(
                              LucideIcons.user,
                              color: Colors.white54,
                              size: 20,
                            )
                          : null,
                    ),
                  ),
              
              const SizedBox(width: 12),
              Expanded(
                child: GestureDetector(
                  onTap: () => context.push('/author-profile/$id'),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            child: CustomTextStyle(
                              text: name,
                              fontSize: 16,
                              maxLine: 1,
                              overflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      CustomTextStyle(
                        text: publishedAt,
                        fontSize: 13,
                        textColor: Colors.white70,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const Divider(thickness: 0.1, endIndent: 20, indent: 20),
      ],
    );
  }
}
