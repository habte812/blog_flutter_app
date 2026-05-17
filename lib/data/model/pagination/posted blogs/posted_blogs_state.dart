import 'package:tech_node/data/model/blog/blogs_preview_model.dart';
import 'package:tech_node/data/model/pagination/saved%20blogs/saved_blogs_state.dart';

class PostedBlogsState<T> {
  final List<BlogsPreviewModel> items;
  final String? nextCursor;
  final bool hasMorePages;
  final PaginationStatus status;
  final String? errorMessage;
  final List<dynamic> layout;
  PostedBlogsState({
    this.items = const [],
    this.nextCursor,
    this.hasMorePages = false,
    this.layout = const [],
    this.status = PaginationStatus.idle,
    this.errorMessage,
  });

 bool get isLoading => status == PaginationStatus.loading;
  bool get isLoadingMore => status == PaginationStatus.loadingMore;
  bool get isFailure => status == PaginationStatus.failure;

  PostedBlogsState copyWith({
    List<BlogsPreviewModel>? items,
    String? nextCursor,
    bool? hasMorePages,
    PaginationStatus? status,
    String? errorMessage,
    List<dynamic>? layout,
    bool clearError = false,
    bool clearCursor = false,
  }) {
    return PostedBlogsState(
      items: items ?? this.items,
      nextCursor: clearCursor ? null : (nextCursor ?? this.nextCursor),
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      status: status ?? this.status,
      hasMorePages: hasMorePages ?? this.hasMorePages,
      layout: layout ?? this.layout,
    );
  }
}
