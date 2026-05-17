// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_converter_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(imageConverterService)
const imageConverterServiceProvider = ImageConverterServiceProvider._();

final class ImageConverterServiceProvider
    extends
        $FunctionalProvider<
          ImageConverterService,
          ImageConverterService,
          ImageConverterService
        >
    with $Provider<ImageConverterService> {
  const ImageConverterServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'imageConverterServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$imageConverterServiceHash();

  @$internal
  @override
  $ProviderElement<ImageConverterService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ImageConverterService create(Ref ref) {
    return imageConverterService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ImageConverterService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ImageConverterService>(value),
    );
  }
}

String _$imageConverterServiceHash() =>
    r'2ea61669276203e82f01daaf95d7088f2f68050c';
