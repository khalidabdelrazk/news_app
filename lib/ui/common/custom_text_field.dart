import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final Color? labelColor;
  final Color? borderColor;
  final Color? inputColor;
  final Color? prefixIconColor;
  final Color? suffixIconColor;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixPressed;
  final String? Function(String?)? validator;
  final bool enabled;
  final int? maxLines;
  final int? maxLength;

  const CustomTextField({
    super.key,
    required this.label,
    this.labelColor,
    this.borderColor,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixPressed,
    this.validator,
    this.enabled = true,
    this.maxLines,
    this.inputColor,
    this.prefixIconColor, this.maxLength, this.suffixIconColor,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      validator: validator,
      maxLines: maxLines,
      maxLength: maxLength,
      style: TextTheme.of(context).displayMedium,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: label,
        alignLabelWithHint: true,
        hintStyle: TextStyle(
          color: Theme.of(context).cardColor,
          fontSize: 18,
          fontWeight: FontWeight.w400,
        ),
        prefixIcon:
            prefixIcon != null
                ? Icon(prefixIcon,color: prefixIconColor ?? Theme.of(context).cardColor,)
                : null,
        suffixIcon:
            suffixIcon != null
                ? IconButton(
                  icon: Icon(suffixIcon, color: suffixIconColor ?? Theme.of(context).cardColor),
                  onPressed: onSuffixPressed,
                )
                : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: borderColor ?? Theme.of(context).primaryColor,
            width: 2,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: borderColor ?? Theme.of(context).cardColor,
            width: 2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: borderColor ?? Theme.of(context).cardColor,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.red, width: 2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.redAccent, width: 2),
        ),
      ),
    );
  }
}
