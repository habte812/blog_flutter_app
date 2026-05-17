// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'follow_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(FollowNotifier)
const followProvider = FollowNotifierFamily._();

final class FollowNotifierProvider
    extends $NotifierProvider<FollowNotifier, bool> {
  const FollowNotifierProvider._({
    required FollowNotifierFamily super.from,
    required (String, bool) super.argument,
  }) : super(
         retry: null,
         name: r'followProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$followNotifierHash();

  @override
  String toString() {
    return r'followProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  FollowNotifier create() => FollowNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is FollowNotifierProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$followNotifierHash() => r'a2aa30a5a38b06d3e9db96e6c9023d7111ee776e';

final class FollowNotifierFamily extends $Family
    with
        $ClassFamilyOverride<FollowNotifier, bool, bool, bool, (String, bool)> {
  const FollowNotifierFamily._()
    : super(
        retry: null,
        name: r'followProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  FollowNotifierProvider call(String authorID, bool intialstate) =>
      FollowNotifierProvider._(argument: (authorID, intialstate), from: this);

  @override
  String toString() => r'followProvider';
}

abstract class _$FollowNotifier extends $Notifier<bool> {
  late final _$args = ref.$arg as (String, bool);
  String get authorID => _$args.$1;
  bool get intialstate => _$args.$2;

  bool build(String authorID, bool intialstate);
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

@ProviderFor(GetFollowingsNotifier)
const getFollowingsProvider = GetFollowingsNotifierProvider._();

final class GetFollowingsNotifierProvider
    extends $AsyncNotifierProvider<GetFollowingsNotifier, List<AuthorModel>> {
  const GetFollowingsNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getFollowingsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getFollowingsNotifierHash();

  @$internal
  @override
  GetFollowingsNotifier create() => GetFollowingsNotifier();
}

String _$getFollowingsNotifierHash() =>
    r'61bdd6ad2a7d2cd1b9cf96af6a34df6abd563ca9';

abstract class _$GetFollowingsNotifier
    extends $AsyncNotifier<List<AuthorModel>> {
  FutureOr<List<AuthorModel>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<AsyncValue<List<AuthorModel>>, List<AuthorModel>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<AuthorModel>>, List<AuthorModel>>,
              AsyncValue<List<AuthorModel>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(GetFollowersNotifier)
const getFollowersProvider = GetFollowersNotifierProvider._();

final class GetFollowersNotifierProvider
    extends $AsyncNotifierProvider<GetFollowersNotifier, List<AuthorModel>> {
  const GetFollowersNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getFollowersProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getFollowersNotifierHash();

  @$internal
  @override
  GetFollowersNotifier create() => GetFollowersNotifier();
}

String _$getFollowersNotifierHash() =>
    r'36fb7a4afb281c72c92571c51ba902da7a1176da';

abstract class _$GetFollowersNotifier
    extends $AsyncNotifier<List<AuthorModel>> {
  FutureOr<List<AuthorModel>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<AsyncValue<List<AuthorModel>>, List<AuthorModel>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<AuthorModel>>, List<AuthorModel>>,
              AsyncValue<List<AuthorModel>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(MyFollowingBlogsNotifier)
const myFollowingBlogsProvider = MyFollowingBlogsNotifierProvider._();

final class MyFollowingBlogsNotifierProvider
    extends
        $NotifierProvider<
          MyFollowingBlogsNotifier,
          FollowingBlogsState<dynamic>
        > {
  const MyFollowingBlogsNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'myFollowingBlogsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$myFollowingBlogsNotifierHash();

  @$internal
  @override
  MyFollowingBlogsNotifier create() => MyFollowingBlogsNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FollowingBlogsState<dynamic> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FollowingBlogsState<dynamic>>(value),
    );
  }
}

String _$myFollowingBlogsNotifierHash() =>
    r'ca77b21fbbaf4a796bd8db9b994483f70263bdd1';

abstract class _$MyFollowingBlogsNotifier
    extends $Notifier<FollowingBlogsState<dynamic>> {
  FollowingBlogsState<dynamic> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<FollowingBlogsState<dynamic>, FollowingBlogsState<dynamic>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                FollowingBlogsState<dynamic>,
                FollowingBlogsState<dynamic>
              >,
              FollowingBlogsState<dynamic>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
