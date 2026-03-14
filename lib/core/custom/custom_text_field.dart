import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CustomTextField extends HookWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? label;
  final String? initialValue;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final bool? obscureText;
  final Widget? prefixIcon;
  final EdgeInsets? contentPadding;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final FontWeight? fontWeight;
  final double fontSize;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;
  final Iterable<String>? autofillHints;
  final bool? readOnly;
  final String? keyForIcon;
  final ValueChanged<String>? onChanged;
  final bool? autofocus;

  const CustomTextField({
    super.key,
    this.controller,
    this.hintText,
    this.maxLines = 1,
    this.prefixIcon,
    this.minLines,
    this.obscureText = false,
    this.maxLength,
    this.textStyle,
    this.hintStyle,
    this.fontWeight,
    this.fontSize = 14,
    this.validator,
    this.contentPadding,
    this.keyboardType,
    this.autofillHints,
    this.readOnly,
    this.keyForIcon = 'w',
    this.onChanged,
    this.autofocus,
    this.label,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    final isclosed = useState<bool>(true);
    return TextFormField(
      initialValue: initialValue,
      onChanged: onChanged,
      readOnly: readOnly ?? false,
      obscureText: obscureText ?? false ? isclosed.value : false,
      controller: controller,
      maxLines: maxLines,
      minLines: minLines,
      maxLength: maxLength,
      validator: validator,
      style:
          textStyle ??
          TextStyle(
            fontSize: fontSize,
            fontWeight: fontWeight ?? FontWeight.normal,
            color: Colors.white,
            height: 1.5,
          ),
      autofocus: autofocus ?? false,
      keyboardType: keyboardType,
      autofillHints: autofillHints,
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.white70,
          fontSize: fontSize,
          fontWeight: FontWeight.w400,
        ),
        labelStyle: const TextStyle(color: Colors.white54),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white10),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
        ),
        counterText: "",
        contentPadding:
            contentPadding ?? .symmetric(horizontal: 8, vertical: 5),
      ),

      // decoration: InputDecoration(
      //   prefixIcon: prefixIcon,
      //   suffixIcon: obscureText == true
      //       ? IconButton(
      //           constraints: const BoxConstraints(),
      //           padding: const EdgeInsets.all(0),
      //           icon: Icon(
      //             isclosed.value
      //                 ? Icons.visibility_outlined
      //                 : Icons.visibility_off_outlined,
      //             color: Theme.of(context).colorScheme.onSurface,
      //           ),
      //           onPressed: () {
      //             isclosed.value = !isclosed.value;
      //           },
      //         )
      //       : keyForIcon == 's'
      //       ? prefixIcon
      //       : null,
      //   hintText: hintText,
      //   hintStyle:
      //       hintStyle ??
      //       TextStyle(
      //         color: Colors.white70,
      //         fontSize: fontSize,
      //         fontWeight: FontWeight.w400,
      //       ),
      //   border: InputBorder.none,
      //   enabledBorder: InputBorder.none,
      //   focusedBorder: InputBorder.none,
      //   contentPadding: const EdgeInsets.symmetric(vertical: 10),
      //   counterText: "",
      // ),
    );
  }
}
