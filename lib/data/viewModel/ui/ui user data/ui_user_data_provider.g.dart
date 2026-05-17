// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ui_user_data_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(UiUserDataProvider)
const uiUserDataProviderProvider = UiUserDataProviderProvider._();

final class UiUserDataProviderProvider
    extends $NotifierProvider<UiUserDataProvider, UiUserModel> {
  const UiUserDataProviderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'uiUserDataProviderProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$uiUserDataProviderHash();

  @$internal
  @override
  UiUserDataProvider create() => UiUserDataProvider();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UiUserModel value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UiUserModel>(value),
    );
  }
}

String _$uiUserDataProviderHash() =>
    r'ed9cce764f2b78af96673679a185e3cf078ae3ef';

abstract class _$UiUserDataProvider extends $Notifier<UiUserModel> {
  UiUserModel build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<UiUserModel, UiUserModel>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<UiUserModel, UiUserModel>,
              UiUserModel,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
