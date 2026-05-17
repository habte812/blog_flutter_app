import 'package:tech_node/data/model/author/author_model.dart';

class BlogsPreviewModel {
  final int id;
  final String? thumbnail;
  final String title;
  final int viewCount;
  final String publishedAt;
  final AuthorModel author;
  final String excerpt;
  final Category category;
  final String? updatedAt;
  final bool isSaved;

  BlogsPreviewModel({
    this.thumbnail,
    required this.id,
    required this.title,
    required this.publishedAt,
    required this.author,
    required this.category,
    required this.viewCount,
    required this.excerpt,
    required this.updatedAt,
    required this.isSaved,
  });
  factory BlogsPreviewModel.fromJson(Map<String, dynamic> json) {
    return BlogsPreviewModel(
      id: json['id'],
      title: json['title'],
      publishedAt: json['time_ago'],
      author: AuthorModel.fromJson(json['author']),
      category: Category.fromJson(json['category']),
      viewCount: json['view_count'],
      thumbnail: json['thumbnail_url'],
      excerpt: json['excerpt'],
      updatedAt: json['updated_content_at'],
      isSaved: json['is_saved'] ?? false,
    );
  }
}

class Category {
  final int id;
  final String name;
  final String? categoryImage;
  Category({required this.id, required this.name, this.categoryImage});
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      categoryImage: json['category_image_url'],
    );
  }
}
