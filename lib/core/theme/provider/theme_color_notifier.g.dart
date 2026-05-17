// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_color_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ThemeColorNotifier)
const themeColorProvider = ThemeColorNotifierProvider._();

final class ThemeColorNotifierProvider
    extends $NotifierProvider<ThemeColorNotifier, Color> {
  const ThemeColorNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'themeColorProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$themeColorNotifierHash();

  @$internal
  @override
  ThemeColorNotifier create() => ThemeColorNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Color value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Color>(value),
    );
  }
}

String _$themeColorNotifierHash() =>
    r'fce4f98a09c1c7e26e1cd5e7d53d7db61996c674';

abstract class _$ThemeColorNotifier extends $Notifier<Color> {
  Color build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<Color, Color>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Color, Color>,
              Color,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
