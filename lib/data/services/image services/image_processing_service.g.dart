// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_processing_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ImageProcessingService)
const imageProcessingServiceProvider = ImageProcessingServiceProvider._();

final class ImageProcessingServiceProvider
    extends $NotifierProvider<ImageProcessingService, AsyncValue<String?>> {
  const ImageProcessingServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'imageProcessingServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$imageProcessingServiceHash();

  @$internal
  @override
  ImageProcessingService create() => ImageProcessingService();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<String?> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<String?>>(value),
    );
  }
}

String _$imageProcessingServiceHash() =>
    r'fd0fdcd3303d13661768270c9648a2d66a270cf2';

abstract class _$ImageProcessingService extends $Notifier<AsyncValue<String?>> {
  AsyncValue<String?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<String?>, AsyncValue<String?>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<String?>, AsyncValue<String?>>,
              AsyncValue<String?>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
