import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tech_node/core/constants/themes.dart';
import 'package:tech_node/core/custom/custom_text_style.dart';

class Featured4Cards extends StatelessWidget {
  const Featured4Cards({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!context.mounted) return;
        context.push('/detail_page/10');
      },
      child: Container(
        clipBehavior: .antiAlias,
        decoration: BoxDecoration(color: card, borderRadius: .circular(10)),
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset('assets/images/im3.jpg', fit: BoxFit.cover),
            ),
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: .circular(10),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.9),
                    ],
                    stops: const [0.4, 1.0],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Container(
                margin: .only(top: 8, right: 8),
                padding: const .symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const CustomTextStyle(
                  text: "Flutter",
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const .only(left: 16, bottom: 16, right: 30),
              child: Align(
                alignment: .bottomLeft,
                child: const CustomTextStyle(
                  text: 'Learn Flutter and Laravel API with Habtemariam',
                  fontSize: 16,
                  maxLine: 2,
                  overflow: TextOverflow.ellipsis,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
