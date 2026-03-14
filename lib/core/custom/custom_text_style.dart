import 'package:flutter/material.dart';

class CustomTextStyle extends StatelessWidget {
  final String text;
  final Color? textColor;
  final FontWeight? fontWeight;
  final double fontSize;
  final int? maxLine;
  final TextOverflow? overflow;
  final TextAlign? textAlign;
  final double? letterSpacing;
  final String? fontFamily;
  final TextDecoration? decoration;
  const CustomTextStyle({
    super.key,
    this.fontFamily,
    required this.text,
    this.textColor,
    required this.fontSize,
    this.fontWeight,
    this.maxLine,
    this.overflow,
    this.textAlign,
    this.letterSpacing,
    this.decoration,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLine,
      overflow: overflow,
      style: TextStyle(
        decoration: decoration,
        color: textColor ?? Colors.white,
        fontSize: fontSize,
        fontWeight: fontWeight,
        overflow: overflow,
        letterSpacing: letterSpacing,
      ),
    );
  }
}
