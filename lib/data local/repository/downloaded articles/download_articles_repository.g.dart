// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'download_articles_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(downloadArticlesRepository)
const downloadArticlesRepositoryProvider =
    DownloadArticlesRepositoryProvider._();

final class DownloadArticlesRepositoryProvider
    extends
        $FunctionalProvider<
          DownloadArticlesRepository,
          DownloadArticlesRepository,
          DownloadArticlesRepository
        >
    with $Provider<DownloadArticlesRepository> {
  const DownloadArticlesRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'downloadArticlesRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$downloadArticlesRepositoryHash();

  @$internal
  @override
  $ProviderElement<DownloadArticlesRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DownloadArticlesRepository create(Ref ref) {
    return downloadArticlesRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DownloadArticlesRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DownloadArticlesRepository>(value),
    );
  }
}

String _$downloadArticlesRepositoryHash() =>
    r'e2b0684d405ea6c682cdd593bd1244162be03e3c';
