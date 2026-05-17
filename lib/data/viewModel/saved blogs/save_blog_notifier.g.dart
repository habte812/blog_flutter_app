// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'save_blog_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SaveBlogNotifier)
const saveBlogProvider = SaveBlogNotifierFamily._();

final class SaveBlogNotifierProvider
    extends $NotifierProvider<SaveBlogNotifier, bool> {
  const SaveBlogNotifierProvider._({
    required SaveBlogNotifierFamily super.from,
    required (int, bool) super.argument,
  }) : super(
         retry: null,
         name: r'saveBlogProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$saveBlogNotifierHash();

  @override
  String toString() {
    return r'saveBlogProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  SaveBlogNotifier create() => SaveBlogNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is SaveBlogNotifierProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$saveBlogNotifierHash() => r'122e8e7ce0d4b7f3b348e807a6ce37816fe9af3a';

final class SaveBlogNotifierFamily extends $Family
    with $ClassFamilyOverride<SaveBlogNotifier, bool, bool, bool, (int, bool)> {
  const SaveBlogNotifierFamily._()
    : super(
        retry: null,
        name: r'saveBlogProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  SaveBlogNotifierProvider call(int blogId, bool intialstate) =>
      SaveBlogNotifierProvider._(argument: (blogId, intialstate), from: this);

  @override
  String toString() => r'saveBlogProvider';
}

abstract class _$SaveBlogNotifier extends $Notifier<bool> {
  late final _$args = ref.$arg as (int, bool);
  int get blogId => _$args.$1;
  bool get intialstate => _$args.$2;

  bool build(int blogId, bool intialstate);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args.$1, _$args.$2);
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

@ProviderFor(MySavedBlogsNotifier)
const mySavedBlogsProvider = MySavedBlogsNotifierProvider._();

final class MySavedBlogsNotifierProvider
    extends $NotifierProvider<MySavedBlogsNotifier, SavedBlogsState> {
  const MySavedBlogsNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mySavedBlogsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mySavedBlogsNotifierHash();

  @$internal
  @override
  MySavedBlogsNotifier create() => MySavedBlogsNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SavedBlogsState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SavedBlogsState>(value),
    );
  }
}

String _$mySavedBlogsNotifierHash() =>
    r'920c6cda0c19b0ff4cc1ebbaa426018707e849a6';

abstract class _$MySavedBlogsNotifier extends $Notifier<SavedBlogsState> {
  SavedBlogsState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<SavedBlogsState, SavedBlogsState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<SavedBlogsState, SavedBlogsState>,
              SavedBlogsState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
