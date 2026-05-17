// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:http/http.dart' as http;

// // ─────────────────────────────────────────────
// // MODELS
// // ─────────────────────────────────────────────

// class Author {
//   final int id;
//   final String name;
//   final String? profilePicture;

//   const Author({
//     required this.id,
//     required this.name,
//     this.profilePicture,
//   });

//   factory Author.fromJson(Map<String, dynamic> json) => Author(
//         id: json['id'] as int,
//         name: json['name'] as String,
//         profilePicture: json['profile_picture'] as String?,
//       );
// }

// class Category {
//   final int id;
//   final String name;
//   final String? categoryImage;

//   const Category({
//     required this.id,
//     required this.name,
//     this.categoryImage,
//   });

//   factory Category.fromJson(Map<String, dynamic> json) => Category(
//         id: json['id'] as int,
//         name: json['name'] as String,
//         categoryImage: json['category_image'] as String?,
//       );
// }

// class BlogPost {
//   final int id;
//   final String title;
//   final String? thumbnail;
//   final String? excerpt;
//   final int viewCount;
//   final int likeCount;
//   final String? publishedAt;
//   final String createdAt;
//   final Author? author;
//   final Category? category;

//   const BlogPost({
//     required this.id,
//     required this.title,
//     this.thumbnail,
//     this.excerpt,
//     required this.viewCount,
//     required this.likeCount,
//     this.publishedAt,
//     required this.createdAt,
//     this.author,
//     this.category,
//   });

//   factory BlogPost.fromJson(Map<String, dynamic> json) => BlogPost(
//         id: json['id'] as int,
//         title: json['title'] as String,
//         thumbnail: json['thumbnail'] as String?,
//         excerpt: json['excerpt'] as String?,
//         viewCount: json['view_count'] as int? ?? 0,
//         likeCount: json['like_count'] as int? ?? 0,
//         publishedAt: json['published_at'] as String?,
//         createdAt: json['created_at'] as String,
//         author: json['author'] != null
//             ? Author.fromJson(json['author'] as Map<String, dynamic>)
//             : null,
//         category: json['category'] != null
//             ? Category.fromJson(json['category'] as Map<String, dynamic>)
//             : null,
//       );
// }

// // ─────────────────────────────────────────────
// // API RESPONSE MODEL
// // ─────────────────────────────────────────────








// // ─────────────────────────────────────────────
// // EXCEPTIONS
// // ─────────────────────────────────────────────

// class ApiException implements Exception {
//   final String message;
//   final int? statusCode;

//   const ApiException(this.message, {this.statusCode});

//   @override
//   String toString() => 'ApiException($statusCode): $message';
// }

// // ─────────────────────────────────────────────
// // API SERVICE
// // ─────────────────────────────────────────────

// abstract class BlogPostRepository {
//   Future<PaginatedResponse<BlogPost>> fetchPosts({
//     String? cursor,
//     int perPage = 10,
//     String? layout,
//   });
// }

// class BlogPostRepositoryImpl implements BlogPostRepository {
//   BlogPostRepositoryImpl({required this.baseUrl, this.client});

//   final String baseUrl;
//   final http.Client? client;

//   http.Client get _client => client ?? http.Client();

//   @override
//   Future<PaginatedResponse<BlogPost>> fetchPosts({
//     String? cursor,
//     int perPage = 10,
//     String? layout,
//   }) async {
//     final uri = Uri.parse('$baseUrl/api/blog-posts').replace(
//       queryParameters: {
//         'per_page': perPage.toString(),
//         if (cursor != null) 'cursor': cursor,
//         if (layout != null) 'layout': layout,
//       },
//     );

//     final response = await _client.get(
//       uri,
//       headers: {
//         'Accept': 'application/json',
//         'Content-Type': 'application/json',
//         // Add your auth token here if needed:
//         // 'Authorization': 'Bearer $token',
//       },
//     );

//     if (response.statusCode != 200) {
//       throw ApiException(
//         'Failed to fetch posts',
//         statusCode: response.statusCode,
//       );
//     }

//     final json = jsonDecode(response.body) as Map<String, dynamic>;

//     final rawData = json['data'] as List<dynamic>;
//     final posts = rawData
//         .map((e) => BlogPost.fromJson(e as Map<String, dynamic>))
//         .toList();

//     return PaginatedResponse<BlogPost>(
//       data: posts,
//       nextCursor: json['next_cursor'] as String?,
//       hasMorePages: json['has_more_pages'] as bool? ?? false,
//       layout: json['layout'] as String? ?? 'grid',
//     );
//   }
// }

// class PaginatedResponse<T> {
//   final List<T> data;
//   final String? nextCursor;
//   final bool hasMorePages;
//   final String layout;

//   const PaginatedResponse({
//     required this.data,
//     this.nextCursor,
//     required this.hasMorePages,
//     required this.layout,
//   });
// }
// // ─────────────────────────────────────────────
// // STATE
// // ─────────────────────────────────────────────

// enum PaginationStatus { idle, loading, loadingMore, success, failure }

// class BlogPostsState {
//   final List<BlogPost> posts;
//   final String? nextCursor;
//   final bool hasMorePages;
//   final PaginationStatus status;
//   final String? errorMessage;

//   const BlogPostsState({
//     this.posts = const [],
//     this.nextCursor,
//     this.hasMorePages = false,
//     this.status = PaginationStatus.idle,
//     this.errorMessage,
//   });

//   bool get isLoading => status == PaginationStatus.loading;
//   bool get isLoadingMore => status == PaginationStatus.loadingMore;
//   bool get isFailure => status == PaginationStatus.failure;

//   BlogPostsState copyWith({
//     List<BlogPost>? posts,
//     String? nextCursor,
//     bool? hasMorePages,
//     PaginationStatus? status,
//     String? errorMessage,
//     bool clearError = false,
//     bool clearCursor = false,
//   }) {
//     return BlogPostsState(
//       posts: posts ?? this.posts,
//       nextCursor: clearCursor ? null : (nextCursor ?? this.nextCursor),
//       hasMorePages: hasMorePages ?? this.hasMorePages,
//       status: status ?? this.status,
//       errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
//     );
//   }
// }

// // ─────────────────────────────────────────────
// // NOTIFIER
// // ─────────────────────────────────────────────

// class BlogPostsNotifier extends StateNotifier<BlogPostsState> {
//   BlogPostsNotifier({required this.repository})
//       : super(const BlogPostsState());

//   final BlogPostRepository repository;

//   static const int _perPage = 10;

//   /// Initial load or full refresh
//   Future<void> fetchPosts({bool refresh = false}) async {
//     if (state.isLoading) return;

//     state = state.copyWith(
//       status: PaginationStatus.loading,
//       clearError: true,
//       clearCursor: true,
//       posts: refresh ? [] : state.posts,
//     );

//     try {
//       final result = await repository.fetchPosts(perPage: _perPage);

//       state = state.copyWith(
//         posts: result.data,
//         nextCursor: result.nextCursor,
//         hasMorePages: result.hasMorePages,
//         status: PaginationStatus.success,
//       );
//     } on ApiException catch (e) {
//       state = state.copyWith(
//         status: PaginationStatus.failure,
//         errorMessage: e.message,
//       );
//     } catch (e) {
//       state = state.copyWith(
//         status: PaginationStatus.failure,
//         errorMessage: 'An unexpected error occurred.',
//       );
//     }
//   }

//   /// Load next page using cursor
//   Future<void> fetchMorePosts() async {
//     if (state.isLoadingMore || !state.hasMorePages || state.nextCursor == null) {
//       return;
//     }

//     state = state.copyWith(status: PaginationStatus.loadingMore);

//     try {
//       final result = await repository.fetchPosts(
//         cursor: state.nextCursor,
//         perPage: _perPage,
//       );

//       state = state.copyWith(
//         posts: [...state.posts, ...result.data],
//         nextCursor: result.nextCursor,
//         hasMorePages: result.hasMorePages,
//         status: PaginationStatus.success,
//       );
//     } on ApiException catch (e) {
//       // Revert to success so user can retry; preserve existing posts
//       state = state.copyWith(
//         status: PaginationStatus.success,
//         errorMessage: e.message,
//       );
//     } catch (_) {
//       state = state.copyWith(
//         status: PaginationStatus.success,
//         errorMessage: 'Failed to load more posts.',
//       );
//     }
//   }
// }

// // ─────────────────────────────────────────────
// // PROVIDERS
// // ─────────────────────────────────────────────

// /// Override this in your app root / ProviderScope for DI
// final blogPostRepositoryProvider = Provider<BlogPostRepository>((ref) {
//   return BlogPostRepositoryImpl(
//     baseUrl: 'https://your-laravel-app.com', // 👈 change this
//   );
// });

// final blogPostsProvider =
//     StateNotifierProvider<BlogPostsNotifier, BlogPostsState>((ref) {
//   final repo = ref.watch(blogPostRepositoryProvider);
//   return BlogPostsNotifier(repository: repo);
// });

// // ─────────────────────────────────────────────
// // PAGE
// // ─────────────────────────────────────────────

// class BlogPostsPage extends ConsumerStatefulWidget {
//   const BlogPostsPage({super.key});

//   @override
//   ConsumerState<BlogPostsPage> createState() => _BlogPostsPageState();
// }

// class _BlogPostsPageState extends ConsumerState<BlogPostsPage> {
//   final _scrollController = ScrollController();

//   @override
//   void initState() {
//     super.initState();
//     _scrollController.addListener(_onScroll);

//     // Fetch on mount
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       ref.read(blogPostsProvider.notifier).fetchPosts();
//     });
//   }

//   @override
//   void dispose() {
//     _scrollController
//       ..removeListener(_onScroll)
//       ..dispose();
//     super.dispose();
//   }

//   void _onScroll() {
//     if (!_scrollController.hasClients) return;
//     final threshold =
//         _scrollController.position.maxScrollExtent * 0.85; // trigger at 85%
//     if (_scrollController.offset >= threshold) {
//       ref.read(blogPostsProvider.notifier).fetchMorePosts();
//     }
//   }

//   Future<void> _onRefresh() async {
//     await ref.read(blogPostsProvider.notifier).fetchPosts(refresh: true);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final state = ref.watch(blogPostsProvider);

//     return Scaffold(
//       backgroundColor: const Color(0xFF0F1117),
//       appBar: AppBar(
//         backgroundColor: const Color(0xFF0F1117),
//         elevation: 0,
//         centerTitle: false,
//         title: const Text(
//           'Blog Posts',
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 22,
//             fontWeight: FontWeight.w700,
//             letterSpacing: -0.5,
//           ),
//         ),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.refresh_rounded, color: Colors.white70),
//             onPressed: state.isLoading ? null : _onRefresh,
//           ),
//         ],
//       ),
//       body: _buildBody(state),
//     );
//   }

//   Widget _buildBody(BlogPostsState state) {
//     // Full page loading
//     if (state.isLoading && state.posts.isEmpty) {
//       return const Center(
//         child: CircularProgressIndicator(
//           valueColor: AlwaysStoppedAnimation(Color(0xFF6C63FF)),
//         ),
//       );
//     }

//     // Full page error (no posts loaded yet)
//     if (state.isFailure && state.posts.isEmpty) {
//       return _ErrorView(
//         message: state.errorMessage ?? 'Something went wrong.',
//         onRetry: () => ref.read(blogPostsProvider.notifier).fetchPosts(),
//       );
//     }

//     return RefreshIndicator(
//       color: const Color(0xFF6C63FF),
//       backgroundColor: const Color(0xFF1C1E2A),
//       onRefresh: _onRefresh,
//       child: CustomScrollView(
//         controller: _scrollController,
//         physics: const AlwaysScrollableScrollPhysics(),
//         slivers: [
//           // Inline error banner (pagination failed)
//           if (state.errorMessage != null && state.posts.isNotEmpty)
//             SliverToBoxAdapter(
//               child: _InlineErrorBanner(
//                 message: state.errorMessage!,
//                 onRetry: () =>
//                     ref.read(blogPostsProvider.notifier).fetchMorePosts(),
//               ),
//             ),

//           // Posts list
//           SliverPadding(
//             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//             sliver: SliverList(
//               delegate: SliverChildBuilderDelegate(
//                 (context, index) {
//                   if (index >= state.posts.length) return null;
//                   return Padding(
//                     padding: const EdgeInsets.only(bottom: 12),
//                     child: _BlogPostCard(post: state.posts[index]),
//                   );
//                 },
//                 childCount: state.posts.length,
//               ),
//             ),
//           ),

//           // Bottom loader / end indicator
//           SliverToBoxAdapter(
//             child: _BottomLoader(
//               isLoadingMore: state.isLoadingMore,
//               hasMorePages: state.hasMorePages,
//               postsLoaded: state.posts.length,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // ─────────────────────────────────────────────
// // WIDGETS
// // ─────────────────────────────────────────────

// class _BlogPostCard extends StatelessWidget {
//   const _BlogPostCard({required this.post});

//   final BlogPost post;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: const Color(0xFF1C1E2A),
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(color: Colors.white.withOpacity(0.07)),
//       ),
//       clipBehavior: Clip.antiAlias,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Thumbnail
//           if (post.thumbnail != null)
//             AspectRatio(
//               aspectRatio: 16 / 9,
//               child: Image.network(
//                 post.thumbnail!,
//                 fit: BoxFit.cover,
//                 errorBuilder: (_, __, ___) => Container(
//                   color: const Color(0xFF252836),
//                   child: const Icon(Icons.broken_image_outlined,
//                       color: Colors.white24, size: 40),
//                 ),
//               ),
//             ),

//           Padding(
//             padding: const EdgeInsets.all(14),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Category chip
//                 if (post.category != null)
//                   Container(
//                     margin: const EdgeInsets.only(bottom: 8),
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
//                     decoration: BoxDecoration(
//                       color: const Color(0xFF6C63FF).withOpacity(0.15),
//                       borderRadius: BorderRadius.circular(6),
//                       border: Border.all(
//                           color: const Color(0xFF6C63FF).withOpacity(0.4)),
//                     ),
//                     child: Text(
//                       post.category!.name,
//                       style: const TextStyle(
//                         color: Color(0xFF9D97FF),
//                         fontSize: 11,
//                         fontWeight: FontWeight.w600,
//                         letterSpacing: 0.3,
//                       ),
//                     ),
//                   ),

//                 // Title
//                 Text(
//                   post.title,
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                     height: 1.4,
//                   ),
//                   maxLines: 2,
//                   overflow: TextOverflow.ellipsis,
//                 ),

//                 // Excerpt
//                 if (post.excerpt != null) ...[
//                   const SizedBox(height: 6),
//                   Text(
//                     post.excerpt!,
//                     style: TextStyle(
//                       color: Colors.white.withOpacity(0.5),
//                       fontSize: 13,
//                       height: 1.5,
//                     ),
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ],

//                 const SizedBox(height: 12),

//                 // Footer: author + stats
//                 Row(
//                   children: [
//                     if (post.author != null) ...[
//                       _AuthorAvatar(author: post.author!),
//                       const SizedBox(width: 8),
//                       Expanded(
//                         child: Text(
//                           post.author!.name,
//                           style: const TextStyle(
//                             color: Colors.white70,
//                             fontSize: 12,
//                             fontWeight: FontWeight.w500,
//                           ),
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       ),
//                     ] else
//                       const Spacer(),
//                     _StatChip(
//                         icon: Icons.remove_red_eye_outlined,
//                         value: post.viewCount),
//                     const SizedBox(width: 10),
//                     _StatChip(
//                         icon: Icons.favorite_border_rounded,
//                         value: post.likeCount),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _AuthorAvatar extends StatelessWidget {
//   const _AuthorAvatar({required this.author});
//   final Author author;

//   @override
//   Widget build(BuildContext context) {
//     if (author.profilePicture != null) {
//       return CircleAvatar(
//         radius: 13,
//         backgroundImage: NetworkImage(author.profilePicture!),
//         backgroundColor: const Color(0xFF252836),
//       );
//     }
//     return CircleAvatar(
//       radius: 13,
//       backgroundColor: const Color(0xFF6C63FF).withOpacity(0.25),
//       child: Text(
//         author.name.isNotEmpty ? author.name[0].toUpperCase() : '?',
//         style: const TextStyle(
//           color: Color(0xFF9D97FF),
//           fontSize: 11,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//     );
//   }
// }

// class _StatChip extends StatelessWidget {
//   const _StatChip({required this.icon, required this.value});
//   final IconData icon;
//   final int value;

//   String _format(int n) {
//     if (n >= 1000) return '${(n / 1000).toStringAsFixed(1)}k';
//     return n.toString();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Icon(icon, size: 13, color: Colors.white38),
//         const SizedBox(width: 3),
//         Text(
//           _format(value),
//           style: const TextStyle(color: Colors.white38, fontSize: 11),
//         ),
//       ],
//     );
//   }
// }

// class _BottomLoader extends StatelessWidget {
//   const _BottomLoader({
//     required this.isLoadingMore,
//     required this.hasMorePages,
//     required this.postsLoaded,
//   });

//   final bool isLoadingMore;
//   final bool hasMorePages;
//   final int postsLoaded;

//   @override
//   Widget build(BuildContext context) {
//     if (isLoadingMore) {
//       return const Padding(
//         padding: EdgeInsets.symmetric(vertical: 24),
//         child: Center(
//           child: SizedBox(
//             width: 24,
//             height: 24,
//             child: CircularProgressIndicator(
//               strokeWidth: 2.5,
//               valueColor: AlwaysStoppedAnimation(Color(0xFF6C63FF)),
//             ),
//           ),
//         ),
//       );
//     }

//     if (!hasMorePages && postsLoaded > 0) {
//       return Padding(
//         padding: const EdgeInsets.symmetric(vertical: 28),
//         child: Center(
//           child: Text(
//             'You\'ve seen all $postsLoaded posts',
//             style: TextStyle(
//               color: Colors.white.withOpacity(0.25),
//               fontSize: 13,
//             ),
//           ),
//         ),
//       );
//     }

//     return const SizedBox(height: 24);
//   }
// }

// class _InlineErrorBanner extends StatelessWidget {
//   const _InlineErrorBanner({required this.message, required this.onRetry});
//   final String message;
//   final VoidCallback onRetry;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
//       decoration: BoxDecoration(
//         color: const Color(0xFFFF5757).withOpacity(0.12),
//         borderRadius: BorderRadius.circular(10),
//         border: Border.all(color: const Color(0xFFFF5757).withOpacity(0.3)),
//       ),
//       child: Row(
//         children: [
//           const Icon(Icons.error_outline_rounded,
//               color: Color(0xFFFF5757), size: 18),
//           const SizedBox(width: 8),
//           Expanded(
//             child: Text(
//               message,
//               style: const TextStyle(color: Color(0xFFFF8A80), fontSize: 13),
//             ),
//           ),
//           TextButton(
//             onPressed: onRetry,
//             style: TextButton.styleFrom(
//               foregroundColor: const Color(0xFFFF5757),
//               padding: const EdgeInsets.symmetric(horizontal: 8),
//               minimumSize: Size.zero,
//               tapTargetSize: MaterialTapTargetSize.shrinkWrap,
//             ),
//             child: const Text('Retry', style: TextStyle(fontSize: 13)),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _ErrorView extends StatelessWidget {
//   const _ErrorView({required this.message, required this.onRetry});
//   final String message;
//   final VoidCallback onRetry;

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Padding(
//         padding: const EdgeInsets.all(32),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             const Icon(Icons.cloud_off_rounded,
//                 color: Colors.white24, size: 56),
//             const SizedBox(height: 16),
//             Text(
//               message,
//               style: const TextStyle(color: Colors.white54, fontSize: 14),
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(height: 20),
//             OutlinedButton.icon(
//               onPressed: onRetry,
//               icon: const Icon(Icons.refresh_rounded, size: 18),
//               label: const Text('Try again'),
//               style: OutlinedButton.styleFrom(
//                 foregroundColor: const Color(0xFF9D97FF),
//                 side: const BorderSide(color: Color(0xFF6C63FF), width: 1.5),
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10)),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }