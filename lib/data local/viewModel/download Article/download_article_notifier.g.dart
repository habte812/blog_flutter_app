// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'download_article_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(DownloadArticleNotifier)
const downloadArticleProvider = DownloadArticleNotifierProvider._();

final class DownloadArticleNotifierProvider
    extends $AsyncNotifierProvider<DownloadArticleNotifier, void> {
  const DownloadArticleNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'downloadArticleProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$downloadArticleNotifierHash();

  @$internal
  @override
  DownloadArticleNotifier create() => DownloadArticleNotifier();
}

String _$downloadArticleNotifierHash() =>
    r'f6fa742e1fcb185055cd4d0bf2a29b4f336ed4bb';

abstract class _$DownloadArticleNotifier extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  void runBuild() {
    build();
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    element.handleValue(ref, null);
  }
}

@ProviderFor(GetListsOfDownloaded)
const getListsOfDownloadedProvider = GetListsOfDownloadedProvider._();

final class GetListsOfDownloadedProvider
    extends
        $AsyncNotifierProvider<GetListsOfDownloaded, List<OfflineBlogsModel>> {
  const GetListsOfDownloadedProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getListsOfDownloadedProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getListsOfDownloadedHash();

  @$internal
  @override
  GetListsOfDownloaded create() => GetListsOfDownloaded();
}

String _$getListsOfDownloadedHash() =>
    r'5ff33edb954b4bca9383afcf5ce33b38d181905b';

abstract class _$GetListsOfDownloaded
    extends $AsyncNotifier<List<OfflineBlogsModel>> {
  FutureOr<List<OfflineBlogsModel>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<
              AsyncValue<List<OfflineBlogsModel>>,
              List<OfflineBlogsModel>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<OfflineBlogsModel>>,
                List<OfflineBlogsModel>
              >,
              AsyncValue<List<OfflineBlogsModel>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(DeleteTheOfflineBlog)
const deleteTheOfflineBlogProvider = DeleteTheOfflineBlogProvider._();

final class DeleteTheOfflineBlogProvider
    extends $AsyncNotifierProvider<DeleteTheOfflineBlog, void> {
  const DeleteTheOfflineBlogProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deleteTheOfflineBlogProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$deleteTheOfflineBlogHash();

  @$internal
  @override
  DeleteTheOfflineBlog create() => DeleteTheOfflineBlog();
}

String _$deleteTheOfflineBlogHash() =>
    r'252e2e8b795fbbd222e25cbb91dbe5dab1a984e2';

abstract class _$DeleteTheOfflineBlog extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  void runBuild() {
    build();
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    element.handleValue(ref, null);
  }
}
