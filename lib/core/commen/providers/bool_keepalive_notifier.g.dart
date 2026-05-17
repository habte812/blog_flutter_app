// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bool_keepalive_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(BoolKeepaliveNotifier)
const boolKeepaliveProvider = BoolKeepaliveNotifierFamily._();

final class BoolKeepaliveNotifierProvider
    extends $NotifierProvider<BoolKeepaliveNotifier, bool> {
  const BoolKeepaliveNotifierProvider._({
    required BoolKeepaliveNotifierFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'boolKeepaliveProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$boolKeepaliveNotifierHash();

  @override
  String toString() {
    return r'boolKeepaliveProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  BoolKeepaliveNotifier create() => BoolKeepaliveNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is BoolKeepaliveNotifierProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$boolKeepaliveNotifierHash() =>
    r'd560461d0dcc8c9dd75902eff2d828e91a2c094f';

final class BoolKeepaliveNotifierFamily extends $Family
    with $ClassFamilyOverride<BoolKeepaliveNotifier, bool, bool, bool, String> {
  const BoolKeepaliveNotifierFamily._()
    : super(
        retry: null,
        name: r'boolKeepaliveProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  BoolKeepaliveNotifierProvider call(String id) =>
      BoolKeepaliveNotifierProvider._(argument: id, from: this);

  @override
  String toString() => r'boolKeepaliveProvider';
}

abstract class _$BoolKeepaliveNotifier extends $Notifier<bool> {
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
