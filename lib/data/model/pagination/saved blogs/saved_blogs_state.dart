import 'package:tech_node/data/model/blog/blogs_preview_model.dart';

enum PaginationStatus { idle, loading, loadingMore, success, failure }

class SavedBlogsState {
  final List<BlogsPreviewModel> savedblogs;
  final String? nextCursor;
  final bool hasMorePages;
  final PaginationStatus status;
  final String? errorMessage;

  const SavedBlogsState({
    this.savedblogs = const [],
    this.nextCursor,
    this.hasMorePages = false,
    this.status = PaginationStatus.idle,
    this.errorMessage,
  });
  bool get isLoading => status == PaginationStatus.loading;
  bool get isLoadingMore => status == PaginationStatus.loadingMore;
  bool get isFailure => status == PaginationStatus.failure;

  SavedBlogsState copyWith({
    List<BlogsPreviewModel>? savedblogs,
    String? nextCursor,
    bool? hasMorePages,
    PaginationStatus? status,
    String? errorMessage,
    bool clearError = false,
    bool clearCursor = false,

  }){return SavedBlogsState(
    savedblogs: savedblogs ?? this.savedblogs,
    nextCursor: clearCursor? null :(nextCursor ?? this.nextCursor),
    hasMorePages: hasMorePages?? this.hasMorePages,
    status: status?? this.status,
    errorMessage: clearError? null: (errorMessage?? this.errorMessage)
  );}
}
