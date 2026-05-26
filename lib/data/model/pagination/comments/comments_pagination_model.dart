import 'package:tech_node/data/model/comment/blog_comment_model.dart';
import 'package:tech_node/data/model/pagination/paginated_response_model.dart';

class CommentsPaginationModel {
  
  final List<BlogCommentModel> comments;
  final String? nextCursor;
  final bool hasMorePages;
  final PaginationStatus status;
  final String? errorMessage;

  const CommentsPaginationModel({
    this.comments = const [],
    this.nextCursor,
    this.hasMorePages = false,
    this.status = PaginationStatus.idle,
    this.errorMessage,
  });
  bool get isLoading => status == PaginationStatus.loading;
  bool get isLoadingMore => status == PaginationStatus.loadingMore;
  bool get isFailure => status == PaginationStatus.failure;

  CommentsPaginationModel copyWith({
    List<BlogCommentModel>? comments,
    String? nextCursor,
    bool? hasMorePages,
    PaginationStatus? status,
    String? errorMessage,
    bool clearError = false,
    bool clearCursor = false,

  }){return CommentsPaginationModel(
    comments: comments ?? this.comments,
    nextCursor: clearCursor? null :(nextCursor ?? this.nextCursor),
    hasMorePages: hasMorePages?? this.hasMorePages,
    status: status?? this.status,
    errorMessage: clearError? null: (errorMessage?? this.errorMessage)
  );}
}