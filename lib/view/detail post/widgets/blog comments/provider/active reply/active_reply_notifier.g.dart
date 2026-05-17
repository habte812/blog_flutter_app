// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'active_reply_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ActiveReplyNotifier)
const activeReplyProvider = ActiveReplyNotifierProvider._();

final class ActiveReplyNotifierProvider
    extends $NotifierProvider<ActiveReplyNotifier, ReplyState> {
  const ActiveReplyNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'activeReplyProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$activeReplyNotifierHash();

  @$internal
  @override
  ActiveReplyNotifier create() => ActiveReplyNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ReplyState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ReplyState>(value),
    );
  }
}

String _$activeReplyNotifierHash() =>
    r'5bb8d00f2a316c7dcc35238497c99f584527a1be';

abstract class _$ActiveReplyNotifier extends $Notifier<ReplyState> {
  ReplyState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<ReplyState, ReplyState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ReplyState, ReplyState>,
              ReplyState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
