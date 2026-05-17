// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'save_blog_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(saveBlogRepository)
const saveBlogRepositoryProvider = SaveBlogRepositoryProvider._();

final class SaveBlogRepositoryProvider
    extends
        $FunctionalProvider<
          SaveBlogRepository,
          SaveBlogRepository,
          SaveBlogRepository
        >
    with $Provider<SaveBlogRepository> {
  const SaveBlogRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'saveBlogRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$saveBlogRepositoryHash();

  @$internal
  @override
  $ProviderElement<SaveBlogRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SaveBlogRepository create(Ref ref) {
    return saveBlogRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SaveBlogRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SaveBlogRepository>(value),
    );
  }
}

String _$saveBlogRepositoryHash() =>
    r'421d2adebfcac9f74d100ff21e2779e3c772a0f0';
