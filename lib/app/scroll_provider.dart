import 'package:flutter/material.dart';

class ScrollProvider extends InheritedWidget {
  final ScrollController homeController;
  final ScrollController exploreController;

  const ScrollProvider({
    super.key,
    required this.homeController,
    required this.exploreController,
    required super.child,
  });

  static ScrollProvider of(BuildContext context) {
    final ScrollProvider? result = 
        context.dependOnInheritedWidgetOfExactType<ScrollProvider>();
    assert(result != null, 'No ScrollProvider found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(ScrollProvider oldWidget) => false; 
}