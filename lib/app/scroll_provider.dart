import 'package:flutter/material.dart';

class ScrollProvider extends InheritedWidget {
  final ScrollController homeController;
  final ScrollController followingController;
  final ScrollController libraryController;
  final ScrollController sattingController;

  const ScrollProvider({
    super.key,
    required this.homeController,
    required this.followingController,
    required this.libraryController,
    required this.sattingController,
    required super.child,
  });

  static ScrollProvider of(BuildContext context) {
    final ScrollProvider? result = context
        .dependOnInheritedWidgetOfExactType<ScrollProvider>();
    assert(result != null, 'No ScrollProvider found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(ScrollProvider oldWidget) => false;
}
