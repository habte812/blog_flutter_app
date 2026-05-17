
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'bool_keepalive_notifier.g.dart';

@Riverpod(keepAlive: true)
class BoolKeepaliveNotifier extends _$BoolKeepaliveNotifier {
  @override
  bool build(String id) {
    return false;
  }

  void toggle() {
    state = !state;
  }
   void setTrue() {
    state = true;
  }
}