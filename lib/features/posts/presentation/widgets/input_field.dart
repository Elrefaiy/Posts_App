import 'package:flutter/material.dart';

class DefaultInputField extends StatelessWidget {
  final String? prefixText;
  final String? hintText;
  final TextEditingController controller;
  final TextStyle textStyle;
  final TextInputType? keyboardType;
  final bool? autofocus;
  final int? maxLines;

  const DefaultInputField({
    this.prefixText,
    this.hintText,
    required this.controller,
    this.maxLines,
    required this.textStyle,
    this.keyboardType,
    this.autofocus,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        border: InputBorder.none,
        prefixText: prefixText ?? '',
        prefixStyle: textStyle,
        hintText: hintText ?? '',
        hintStyle: textStyle,
      ),
      autofocus: autofocus ?? false,
      keyboardType: keyboardType ?? TextInputType.multiline,
      maxLines: maxLines ?? 1,
      style: textStyle,
    );
  }
}
