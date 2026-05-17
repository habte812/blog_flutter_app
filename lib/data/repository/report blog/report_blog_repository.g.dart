// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_blog_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(reportBlogRepository)
const reportBlogRepositoryProvider = ReportBlogRepositoryProvider._();

final class ReportBlogRepositoryProvider
    extends
        $FunctionalProvider<
          ReportBlogRepository,
          ReportBlogRepository,
          ReportBlogRepository
        >
    with $Provider<ReportBlogRepository> {
  const ReportBlogRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'reportBlogRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$reportBlogRepositoryHash();

  @$internal
  @override
  $ProviderElement<ReportBlogRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ReportBlogRepository create(Ref ref) {
    return reportBlogRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ReportBlogRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ReportBlogRepository>(value),
    );
  }
}

String _$reportBlogRepositoryHash() =>
    r'7bed7a5337963f42f9da3f778dbc413aed2c372e';
