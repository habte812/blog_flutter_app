class ReportBlogModel {
  final int blogId;
  final String reason;
  final String? detail;

  ReportBlogModel({
    required this.blogId,
    required this.reason,
     this.detail,
  });

  ReportBlogModel copyWith({
    int? blogId,
    String? reason,
    String? detail,
  }) {
    return ReportBlogModel(
      blogId: blogId ?? this.blogId,
      reason: reason ?? this.reason,
      detail: detail ?? this.detail,
    );
  }
}
