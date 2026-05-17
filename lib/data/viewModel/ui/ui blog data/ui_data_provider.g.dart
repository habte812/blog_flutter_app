// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ui_data_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(UiDataProvider)
const uiDataProviderProvider = UiDataProviderProvider._();

final class UiDataProviderProvider
    extends $NotifierProvider<UiDataProvider, CreateBlogDataModel> {
  const UiDataProviderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'uiDataProviderProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$uiDataProviderHash();

  @$internal
  @override
  UiDataProvider create() => UiDataProvider();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CreateBlogDataModel value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CreateBlogDataModel>(value),
    );
  }
}

String _$uiDataProviderHash() => r'66b5c2fbdb5fe459065cbb45775a70cbea2e74d3';

abstract class _$UiDataProvider extends $Notifier<CreateBlogDataModel> {
  CreateBlogDataModel build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<CreateBlogDataModel, CreateBlogDataModel>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<CreateBlogDataModel, CreateBlogDataModel>,
              CreateBlogDataModel,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
