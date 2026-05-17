// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'catche_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CatcheNotifier)
const catcheProvider = CatcheNotifierProvider._();

final class CatcheNotifierProvider
    extends $AsyncNotifierProvider<CatcheNotifier, Map<String, String>> {
  const CatcheNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'catcheProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$catcheNotifierHash();

  @$internal
  @override
  CatcheNotifier create() => CatcheNotifier();
}

String _$catcheNotifierHash() => r'0f11496452f1a40e00ef80f43b4bb73f5d04709f';

abstract class _$CatcheNotifier extends $AsyncNotifier<Map<String, String>> {
  FutureOr<Map<String, String>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<AsyncValue<Map<String, String>>, Map<String, String>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<Map<String, String>>, Map<String, String>>,
              AsyncValue<Map<String, String>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
