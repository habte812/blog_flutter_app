// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comments_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CommentsNotifier)
const commentsProvider = CommentsNotifierFamily._();

final class CommentsNotifierProvider
    extends $AsyncNotifierProvider<CommentsNotifier, List<BlogCommentModel>> {
  const CommentsNotifierProvider._({
    required CommentsNotifierFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'commentsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$commentsNotifierHash();

  @override
  String toString() {
    return r'commentsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  CommentsNotifier create() => CommentsNotifier();

  @override
  bool operator ==(Object other) {
    return other is CommentsNotifierProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$commentsNotifierHash() => r'c98bb8588a3219e881808fccbf9ced02886928d0';

final class CommentsNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          CommentsNotifier,
          AsyncValue<List<BlogCommentModel>>,
          List<BlogCommentModel>,
          FutureOr<List<BlogCommentModel>>,
          String
        > {
  const CommentsNotifierFamily._()
    : super(
        retry: null,
        name: r'commentsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  CommentsNotifierProvider call(String postId) =>
      CommentsNotifierProvider._(argument: postId, from: this);

  @override
  String toString() => r'commentsProvider';
}

abstract class _$CommentsNotifier
    extends $AsyncNotifier<List<BlogCommentModel>> {
  late final _$args = ref.$arg as String;
  String get postId => _$args;

  FutureOr<List<BlogCommentModel>> build(String postId);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref =
        this.ref
            as $Ref<AsyncValue<List<BlogCommentModel>>, List<BlogCommentModel>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<BlogCommentModel>>,
                List<BlogCommentModel>
              >,
              AsyncValue<List<BlogCommentModel>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(GetcommentRepliesNotifier)
const getcommentRepliesProvider = GetcommentRepliesNotifierFamily._();

final class GetcommentRepliesNotifierProvider
    extends
        $AsyncNotifierProvider<
          GetcommentRepliesNotifier,
          List<BlogCommentModel>
        > {
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
    r'c11720eaf16eb98231b891e39e9d042fbf1aafc3';

final class GetcommentRepliesNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          GetcommentRepliesNotifier,
          AsyncValue<List<BlogCommentModel>>,
          List<BlogCommentModel>,
          FutureOr<List<BlogCommentModel>>,
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
    extends $AsyncNotifier<List<BlogCommentModel>> {
  late final _$args = ref.$arg as int;
  int get parentId => _$args;

  FutureOr<List<BlogCommentModel>> build(int parentId);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref =
        this.ref
            as $Ref<AsyncValue<List<BlogCommentModel>>, List<BlogCommentModel>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<BlogCommentModel>>,
                List<BlogCommentModel>
              >,
              AsyncValue<List<BlogCommentModel>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
