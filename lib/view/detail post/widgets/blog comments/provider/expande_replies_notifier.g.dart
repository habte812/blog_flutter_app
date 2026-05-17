// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expande_replies_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ExpandeRepliesNotifier)
const expandeRepliesProvider = ExpandeRepliesNotifierFamily._();

final class ExpandeRepliesNotifierProvider
    extends $NotifierProvider<ExpandeRepliesNotifier, bool> {
  const ExpandeRepliesNotifierProvider._({
    required ExpandeRepliesNotifierFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'expandeRepliesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$expandeRepliesNotifierHash();

  @override
  String toString() {
    return r'expandeRepliesProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  ExpandeRepliesNotifier create() => ExpandeRepliesNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is ExpandeRepliesNotifierProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$expandeRepliesNotifierHash() =>
    r'f0b99062277b888fe514699ceb9481c96f58390c';

final class ExpandeRepliesNotifierFamily extends $Family
    with
        $ClassFamilyOverride<ExpandeRepliesNotifier, bool, bool, bool, String> {
  const ExpandeRepliesNotifierFamily._()
    : super(
        retry: null,
        name: r'expandeRepliesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ExpandeRepliesNotifierProvider call(String id) =>
      ExpandeRepliesNotifierProvider._(argument: id, from: this);

  @override
  String toString() => r'expandeRepliesProvider';
}

abstract class _$ExpandeRepliesNotifier extends $Notifier<bool> {
  late final _$args = ref.$arg as String;
  String get id => _$args;

  bool build(String id);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref = this.ref as $Ref<bool, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<bool, bool>,
              bool,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
