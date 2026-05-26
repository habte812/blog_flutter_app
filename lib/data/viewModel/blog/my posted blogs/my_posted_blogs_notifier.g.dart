// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_posted_blogs_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(MyPostedBlogsNotifier)
const myPostedBlogsProvider = MyPostedBlogsNotifierProvider._();

final class MyPostedBlogsNotifierProvider
    extends $NotifierProvider<MyPostedBlogsNotifier, MyPostedBlogsState> {
  const MyPostedBlogsNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'myPostedBlogsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$myPostedBlogsNotifierHash();

  @$internal
  @override
  MyPostedBlogsNotifier create() => MyPostedBlogsNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MyPostedBlogsState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MyPostedBlogsState>(value),
    );
  }
}

String _$myPostedBlogsNotifierHash() =>
    r'10b5a36814f9b5b2d96ca36ef9c6711f2af173d6';

abstract class _$MyPostedBlogsNotifier extends $Notifier<MyPostedBlogsState> {
  MyPostedBlogsState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<MyPostedBlogsState, MyPostedBlogsState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<MyPostedBlogsState, MyPostedBlogsState>,
              MyPostedBlogsState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
