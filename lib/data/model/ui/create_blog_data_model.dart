class CreateBlogDataModel {
  final String blogTitle;
  final String blogCategory;
  final String blogContent;
  final List<String> listOfHashtags;
  final String? hashtags;
  final String? blogThumbnailPath;
  final int? editBlogId;
  final String? editThumbnailUrl;

  const CreateBlogDataModel({
    this.blogTitle = '',
    this.blogCategory = '',
    this.blogContent = '',
    this.listOfHashtags = const [],
    this.blogThumbnailPath,
    this.hashtags,
    this.editBlogId,
    this.editThumbnailUrl
  });

  CreateBlogDataModel copyWith({
    String? blogTitle,
    String? blogCategory,
    String? blogContent,
    List<String>? listOfHashtags,
    String? blogThumbnailPath,
    String? hashtags,
    int? editBlogId,
    String?editThumbnailUrl
  }) {
    return CreateBlogDataModel(
      blogTitle: blogTitle ?? this.blogTitle,
      blogCategory: blogCategory ?? this.blogCategory,
      blogContent: blogContent ?? this.blogContent,
      listOfHashtags: listOfHashtags ?? this.listOfHashtags,
      blogThumbnailPath: blogThumbnailPath ?? this.blogThumbnailPath,
      hashtags: hashtags ?? this.hashtags,
      editBlogId: editBlogId ?? this.editBlogId,
      editThumbnailUrl: editThumbnailUrl?? this.editThumbnailUrl
    );
  }
}

class UiDataModelAuth {
  final String blogTitle;
  final String blogCategory;
  final String blogContent;
  final List<String>? hashtags;
  const UiDataModelAuth({
    this.blogTitle = '',
    this.blogCategory = '',
    this.blogContent = '',
    this.hashtags = const [],
  });

  UiDataModelAuth copyWith({
    String? blogTitle,
    String? blogCategory,
    String? blogContent,
    List<String>? hashtags,
  }) {
    return UiDataModelAuth(
      blogTitle: blogTitle ?? this.blogTitle,
      blogCategory: blogCategory ?? this.blogCategory,
      blogContent: blogContent ?? this.blogContent,
      hashtags: hashtags ?? this.hashtags,
    );
  }
}
