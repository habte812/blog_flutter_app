import 'package:tech_node/data/model/blog/blogs_preview_model.dart';

class BlogsDetailModel {
  final BlogsPreviewModel previewDatas;
  final String slug;
  final String content;
  final int shareCount;
  final int commentCount;
  final Seo seos;
  final bool isOwner;
  final String createdAt;

  BlogsDetailModel({
    required this.previewDatas,
    required this.slug,
    required this.content,
    required this.shareCount,
    required this.commentCount,
    required this.seos,
    required this.isOwner,
    required this.createdAt
  });
  factory BlogsDetailModel.fromJson(Map<String, dynamic> json) {
    return BlogsDetailModel(
      previewDatas: BlogsPreviewModel.fromJson(json),
      slug: json['slug'],
      content: json['content'],
      shareCount: json['share_count'],
      commentCount: json['commet_count'],
      seos: Seo.fromJson(json['seo']),
      isOwner: json['is_owner'],
      createdAt: json['created_at']
    );
  }
}

class Seo {
  final int id;
  final String metaTitle;
  final String metaDescription;
  final String metaKeywords;
  Seo({
    required this.id,
    required this.metaTitle,
    required this.metaDescription,
    required this.metaKeywords,
  });
  factory Seo.fromJson(Map<String, dynamic> json) {
    return Seo(
      id: json['id'],
      metaTitle: json['meta_title'],
      metaDescription: json['meta_description'],
      metaKeywords: json['meta_keywords'],
    );
  }
}
