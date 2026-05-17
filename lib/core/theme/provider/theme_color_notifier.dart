
import 'dart:ui';

import 'package:hive_ce/hive.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme_color_notifier.g.dart';

@riverpod
class ThemeColorNotifier extends _$ThemeColorNotifier {
  @override
  Color build() {
    final box = Hive.box('settings');
    final themeColor = box.get('theme_color');
    if (themeColor != null) {
      return Color(themeColor);
    }
    return const Color(0xff137fec);
  }

  void changeThemeColor(Color color) {
    state = color;
    Hive.box('settings').put('theme_color', color.toARGB32());
  }
}