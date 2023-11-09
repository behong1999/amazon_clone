import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  const CustomTextfield({
    super.key,
    required this.controller,
    this.hintText,
    this.obscure,
    this.customValidator,
    this.suffix,
    this.maxLines,
  });

  final TextEditingController controller;
  final bool? obscure;
  final int? maxLines;
  final Widget? suffix;
  final String? hintText;
  final String? Function(String?)? customValidator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines ?? 1,
      obscureText: obscure ?? false,
      validator: (val) {
        if (customValidator != null) {
          final customError = customValidator!(val);
          if (customError != null) {
            return customError;
          }
        }

        if (val == null || val.isEmpty) {
          return 'Enter your $hintText';
        }
        return null;
      },
      decoration: InputDecoration(
          hintText: hintText,
          suffixIcon: suffix,
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black38))),
    );
  }
}
