import 'package:hive_ce/hive.dart';

part 'offline_blogs_model.g.dart';

@HiveType(typeId: 0)
class OfflineBlogsModel extends HiveObject {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String? thumbnail;
  @HiveField(2)
  final String title;
  @HiveField(3)
  final int viewCount;
  @HiveField(4)
  final String publishedAt;
  @HiveField(5)
  final int authorID;
  @HiveField(6)
  final String authorName;
  @HiveField(7)
  final String? authorImage;
  @HiveField(8)
  final String excerpt;
  @HiveField(9)
  final int categoryID;
  @HiveField(10)
  final String categoryName;
  @HiveField(11)
  final String? updatedAt;
  @HiveField(12)
  final String slug;
  @HiveField(13)
  final String content;
  @HiveField(14)
  final int shareCount;

  OfflineBlogsModel({
    required this.slug,
    required this.content,
    required this.shareCount,
    this.thumbnail,
    required this.id,
    required this.title,
    required this.publishedAt,
    required this.authorID,
    required this.authorName,
     this.authorImage,
    required this.categoryID,
    required this.categoryName,
    required this.viewCount,
    required this.excerpt,
     this.updatedAt,
  });
  OfflineBlogsModel copyWith({
    int? id,
    String? slug,
    String? title,
    String? content,
    String? thumbnail,
    String? authorName,
    String? authorImage,
    int? shareCount,
    int? viewCount,
    String? publishedAt,
    int? authorID,
    int? categoryID,
    String?categoryName,
    String?excerpt
  }) {
    return OfflineBlogsModel(
      id: id ?? this.id,
      slug: slug ?? this.slug,
      title: title ?? this.title,
      excerpt: excerpt??this.excerpt,
      content: content ?? this.content,
      thumbnail: thumbnail ?? this.thumbnail,
      authorName: authorName ?? this.authorName,
      authorID: authorID?? this.authorID,
      categoryID: categoryID?? this.categoryID,
      categoryName: categoryName?? this.categoryName,
      authorImage: authorImage ?? this.authorImage,
      shareCount: shareCount ?? this.shareCount,
      viewCount: viewCount ?? this.viewCount,
      publishedAt: publishedAt ?? this.publishedAt,
    );
  }
}
