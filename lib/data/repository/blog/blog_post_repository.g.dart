// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blog_post_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(blogPostRepository)
const blogPostRepositoryProvider = BlogPostRepositoryProvider._();

final class BlogPostRepositoryProvider
    extends
        $FunctionalProvider<
          BlogPostRepository,
          BlogPostRepository,
          BlogPostRepository
        >
    with $Provider<BlogPostRepository> {
  const BlogPostRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'blogPostRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$blogPostRepositoryHash();

  @$internal
  @override
  $ProviderElement<BlogPostRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  BlogPostRepository create(Ref ref) {
    return blogPostRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BlogPostRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BlogPostRepository>(value),
    );
  }
}

String _$blogPostRepositoryHash() =>
    r'63926584026fc8e7db2650effedb546f031bc9eb';
