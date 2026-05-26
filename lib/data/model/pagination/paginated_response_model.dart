
enum PaginationStatus { idle, loading, loadingMore, success, failure }


class PaginatedResponseModel<T> {
  final List<T> data;
  final String? nextCursor;
  final bool hasMorePages;
  final List<dynamic> layout;

  const PaginatedResponseModel({
    required this.data,
    this.nextCursor,
    required this.hasMorePages,
    required this.layout,
  });
}
