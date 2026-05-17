// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blog_feed_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(BlogFeedNotifier)
const blogFeedProvider = BlogFeedNotifierProvider._();

final class BlogFeedNotifierProvider
    extends $NotifierProvider<BlogFeedNotifier, PostedBlogsState<dynamic>> {
  const BlogFeedNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'blogFeedProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$blogFeedNotifierHash();

  @$internal
  @override
  BlogFeedNotifier create() => BlogFeedNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PostedBlogsState<dynamic> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PostedBlogsState<dynamic>>(value),
    );
  }
}

String _$blogFeedNotifierHash() => r'cedcf38b2955e3c9e9882acf58ac1881d8723b8a';

abstract class _$BlogFeedNotifier extends $Notifier<PostedBlogsState<dynamic>> {
  PostedBlogsState<dynamic> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<PostedBlogsState<dynamic>, PostedBlogsState<dynamic>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<PostedBlogsState<dynamic>, PostedBlogsState<dynamic>>,
              PostedBlogsState<dynamic>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
