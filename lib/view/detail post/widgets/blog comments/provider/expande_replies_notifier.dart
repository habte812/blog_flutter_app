import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'expande_replies_notifier.g.dart';

@riverpod
class ExpandeRepliesNotifier extends _$ExpandeRepliesNotifier {
  @override
  bool build(String id) {
    final keepMe = ref.keepAlive();
    Timer(const Duration(seconds: 30), () => keepMe.close());
    return false;
  }

  void toggle() {
    state = !state;
  }
}
