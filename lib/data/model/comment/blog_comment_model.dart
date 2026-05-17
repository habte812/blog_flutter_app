import 'package:tech_node/data/model/author/author_model.dart';

class BlogCommentModel {
  final AuthorModel writer;
  final int id;
  final int postId;
  final int userId;
  final int? parentId;
  final String content;
  final String createdAt;
  final String updatedAt;
  final int totalReplies;
  final List<BlogCommentModel> replies;

  BlogCommentModel({
    required this.id,
    required this.writer,
    required this.content,
    this.replies = const [],
    this.parentId,
    required this.postId,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    required this.totalReplies,
  });
  factory BlogCommentModel.fromJson(Map<String, dynamic> json) {
    return BlogCommentModel(
      id: json['id'],
      writer: AuthorModel.fromJson(json['user']),
      parentId: json['parent_id'],
      content: json['content'],
      postId: json['post_id'],
      userId: json['user_id'],
      createdAt: json['created_time_ago'],
      updatedAt: json['updated_time_ago'],
      totalReplies: json['replies_count'],
    );
  }
  BlogCommentModel copyWith({int? totalReplies}) {
    return BlogCommentModel(
      id: id,
      content: content,
      writer: writer,
      postId: postId,
      userId: userId,
      createdAt: createdAt,
      updatedAt: updatedAt,
      totalReplies: totalReplies ?? this.totalReplies, // Update this
      parentId: parentId,
    );
  }
}
