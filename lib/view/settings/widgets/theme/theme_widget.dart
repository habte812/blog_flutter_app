import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tech_node/core/theme/provider/theme_color_notifier.dart';
class ThemeWidget extends StatelessWidget {
  const ThemeWidget({super.key});

  @override
  Widget build(BuildContext context) {
        final List<Color> accentColors = [
      const Color(0xff137fec),
      const Color(0xff2F2FE4),
      const Color(0xff48A111),
      const Color(0xff8C5A3C),
      const Color(0xffF26076),
      const Color(0xffB500B2),
      const Color(0xffFF3E9B),
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Wrap(
        spacing: 15,
        children: accentColors.map((color) {
          return Consumer(
            builder: (context, ref, child) {
              final themeColor = ref.watch(themeColorProvider);
              return GestureDetector(
                onTap: () {
                  ref.read(themeColorProvider.notifier).changeThemeColor(color);
                  debugPrint('Theme color changed to: ${color.toARGB32()}');
                },

                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: themeColor == color
                          ? Colors.white
                          : Colors.transparent,
                      width: 2,
                    ),
                  ),
                  child: themeColor == color
                      ? const Icon(Icons.check, color: Colors.white, size: 20)
                      : null,
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }
}
