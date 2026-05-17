import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tech_node/core/constants/themes.dart';
import 'package:tech_node/core/custom/custom_text_style.dart';

// ── Palette ───────────────────────────────────────────────────────────────────
class C {
  // Backgrounds
  static const bg = Color(0xFF0E0F14);
  static const surface = Color(0xFF161820);
  static const surfaceRaised = Color(0xFF1C1E28);
  static const surfaceBorder = Color(0xFF272A36);

  // Accent — electric teal
  static const teal = Color(0xFF00C9A7);
  static const tealDim = Color(0xFF00A589);
  static const tealGlow = Color(0xFF00C9A720);
  static const tealSubtle = Color(0xFF00C9A710);

  // Typography
  static const textHigh = Color(0xFFF0F1F5);
  static const textMid = Color(0xFF8A8FA8);
  static const textLow = Color(0xFF4A4E62);

  // Feature colors
  static const indigo = Color(0xFF6366F1);
  static const rose = Color(0xFFF43F5E);
  static const gold = Color(0xFFF59E0B);
  static const sage = Color(0xFF22C55E);
}

// ── CreateBlogGuestPage ───────────────────────────────────────────────────────

// ── Reusable widgets ──────────────────────────────────────────────────────────

class GhostText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  final bool typewriterVisible;

  const GhostText({
    super.key,
    required this.text,
    required this.fontSize,
    required this.fontWeight,
    required this.color,
    this.typewriterVisible = false,
  });

  @override
  Widget build(BuildContext context) => Text(
    text,
    style: TextStyle(
      fontFamily: 'Georgia',
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      fontStyle: FontStyle.italic,
    ),
  );
}

class GhostLine extends StatelessWidget {
  final double width;
  final double opacity;
  const GhostLine({super.key, required this.width, required this.opacity});

  @override
  Widget build(BuildContext context) => Container(
    width: width,
    height: 10,
    decoration: BoxDecoration(
      color: C.textLow.withValues(alpha: opacity),
      borderRadius: BorderRadius.circular(5),
    ),
  );
}



class StatPill extends StatelessWidget {
  final String value;
  final String label;
  final Color color;
  const StatPill({
    super.key,
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) => Expanded(
    child: Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontFamily: 'Georgia',
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: color,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Georgia',
            fontSize: 11,
            color: C.textMid,
          ),
        ),
      ],
    ),
  );
}

class VertDivider extends StatelessWidget {
  const VertDivider({super.key});

  @override
  Widget build(BuildContext context) =>
      Container(width: 1, height: 36, color: C.surfaceBorder);
}

class StoryCard {
  final String title;
  final String author;
  final String reads;
  final String tag;
  final Color tagColor;
  final Color avatarColor;
  const StoryCard({
    required this.title,
    required this.author,
    required this.reads,
    required this.tag,
    required this.tagColor,
    required this.avatarColor,
  });
}
