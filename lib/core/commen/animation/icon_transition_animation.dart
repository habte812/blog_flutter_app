import 'package:flutter/material.dart';
import 'package:tech_node/core/constants/themes.dart';

class IconTransitionAnimation extends StatefulWidget {
  final bool isSaved;
  final VoidCallback onTap;
  final double iconSize;
  const IconTransitionAnimation({
    super.key,
    required this.isSaved,
    required this.onTap,
    required this.iconSize,
  });

  @override
  State<IconTransitionAnimation> createState() =>
      _IconTransitionAnimationState();
}

class _IconTransitionAnimationState extends State<IconTransitionAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    _scale = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.3), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 1.3, end: 1.0), weight: 50),
    ]).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void didUpdateWidget(IconTransitionAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isSaved != oldWidget.isSaved) {
      _controller.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scale,
      child: IconButton(
        highlightColor: background,
        onPressed: widget.onTap,
        icon: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return ScaleTransition(scale: animation, child: child);
          },
          child: Icon(
            widget.isSaved ? Icons.bookmark : Icons.bookmark_border,
            key: ValueKey<bool>(widget.isSaved),
            color: widget.isSaved ? context.primary : Colors.white54,
            size: widget.iconSize,
          ),
        ),
      ),
    );
  }
}
