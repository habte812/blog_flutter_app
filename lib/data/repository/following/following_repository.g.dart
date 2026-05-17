// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'following_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(followingRepository)
const followingRepositoryProvider = FollowingRepositoryProvider._();

final class FollowingRepositoryProvider
    extends
        $FunctionalProvider<
          FollowingRepository,
          FollowingRepository,
          FollowingRepository
        >
    with $Provider<FollowingRepository> {
  const FollowingRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'followingRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$followingRepositoryHash();

  @$internal
  @override
  $ProviderElement<FollowingRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  FollowingRepository create(Ref ref) {
    return followingRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FollowingRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FollowingRepository>(value),
    );
  }
}

String _$followingRepositoryHash() =>
    r'ce74c30b5ff84e5cbe7ed35cf106732a245cb197';
