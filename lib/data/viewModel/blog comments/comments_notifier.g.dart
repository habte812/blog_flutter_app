// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comments_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(GetcommentRepliesNotifier)
const getcommentRepliesProvider = GetcommentRepliesNotifierFamily._();

final class GetcommentRepliesNotifierProvider
    extends $NotifierProvider<GetcommentRepliesNotifier, CommentRepliesState> {
  const GetcommentRepliesNotifierProvider._({
    required GetcommentRepliesNotifierFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'getcommentRepliesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$getcommentRepliesNotifierHash();

  @override
  String toString() {
    return r'getcommentRepliesProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  GetcommentRepliesNotifier create() => GetcommentRepliesNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CommentRepliesState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CommentRepliesState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is GetcommentRepliesNotifierProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$getcommentRepliesNotifierHash() =>
    r'21e9a16dbbbbba4ac0484a285e3c86b3f444d770';

final class GetcommentRepliesNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          GetcommentRepliesNotifier,
          CommentRepliesState,
          CommentRepliesState,
          CommentRepliesState,
          int
        > {
  const GetcommentRepliesNotifierFamily._()
    : super(
        retry: null,
        name: r'getcommentRepliesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  GetcommentRepliesNotifierProvider call(int parentId) =>
      GetcommentRepliesNotifierProvider._(argument: parentId, from: this);

  @override
  String toString() => r'getcommentRepliesProvider';
}

abstract class _$GetcommentRepliesNotifier
    extends $Notifier<CommentRepliesState> {
  late final _$args = ref.$arg as int;
  int get parentId => _$args;

  CommentRepliesState build(int parentId);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref = this.ref as $Ref<CommentRepliesState, CommentRepliesState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<CommentRepliesState, CommentRepliesState>,
              CommentRepliesState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(FetchBlogCommentsNotifier)
const fetchBlogCommentsProvider = FetchBlogCommentsNotifierFamily._();

final class FetchBlogCommentsNotifierProvider
    extends $NotifierProvider<FetchBlogCommentsNotifier, BlogCommentsState> {
  const FetchBlogCommentsNotifierProvider._({
    required FetchBlogCommentsNotifierFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'fetchBlogCommentsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$fetchBlogCommentsNotifierHash();

  @override
  String toString() {
    return r'fetchBlogCommentsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  FetchBlogCommentsNotifier create() => FetchBlogCommentsNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BlogCommentsState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BlogCommentsState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is FetchBlogCommentsNotifierProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$fetchBlogCommentsNotifierHash() =>
    r'c0a010e8e0e53df97a1d1c91f51ddf29a474e9de';

final class FetchBlogCommentsNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          FetchBlogCommentsNotifier,
          BlogCommentsState,
          BlogCommentsState,
          BlogCommentsState,
          String
        > {
  const FetchBlogCommentsNotifierFamily._()
    : super(
        retry: null,
        name: r'fetchBlogCommentsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  FetchBlogCommentsNotifierProvider call(String postId) =>
      FetchBlogCommentsNotifierProvider._(argument: postId, from: this);

  @override
  String toString() => r'fetchBlogCommentsProvider';
}

abstract class _$FetchBlogCommentsNotifier
    extends $Notifier<BlogCommentsState> {
  late final _$args = ref.$arg as String;
  String get postId => _$args;

  BlogCommentsState build(String postId);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref = this.ref as $Ref<BlogCommentsState, BlogCommentsState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<BlogCommentsState, BlogCommentsState>,
              BlogCommentsState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
