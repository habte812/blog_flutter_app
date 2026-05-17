import 'package:flutter_riverpod/legacy.dart';

final downloadProgressNotifier = StateProvider.family<double, String>((
  ref,
  url,
) {
  return 0.0;
});
