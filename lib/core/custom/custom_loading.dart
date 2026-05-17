import 'package:flutter/material.dart';
import 'package:tech_node/core/constants/themes.dart';

class CustomLoading extends StatelessWidget {
  final Color? color;
  const CustomLoading({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const .all(16.0),
      child: Center(
        child: SizedBox(
          height: 30,
          width: 30,
          child: CircularProgressIndicator(
            color: color ?? context.primary,
            strokeWidth: 2,
          ),
        ),
      ),
    );
  }
}

class CustomLineLoading extends StatelessWidget {
  final Color? color;
  const CustomLineLoading({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      color: color ?? context.primary,
      backgroundColor: background,
    );
  }
}
