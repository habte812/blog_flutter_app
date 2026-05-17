// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_blog_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ReportBlogNotifier)
const reportBlogProvider = ReportBlogNotifierProvider._();

final class ReportBlogNotifierProvider
    extends $AsyncNotifierProvider<ReportBlogNotifier, String?> {
  const ReportBlogNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'reportBlogProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$reportBlogNotifierHash();

  @$internal
  @override
  ReportBlogNotifier create() => ReportBlogNotifier();
}

String _$reportBlogNotifierHash() =>
    r'89119a356065585f35f1f6ec08fa19be0dab375d';

abstract class _$ReportBlogNotifier extends $AsyncNotifier<String?> {
  FutureOr<String?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<String?>, String?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<String?>, String?>,
              AsyncValue<String?>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
