import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final String? suffixIconPath;
  final TextEditingController? controller;
  final String? errorText;
  final int? maxLines;
  final bool? autoFocus;
  final double? radius;
  final bool readOnly;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final Widget? prefixIcon;
  final int? maxLength;
  final String? Function(String? value)? validator;
  final void Function(String? value)? onSave;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  final void Function()? suffixIconTap;

  const CustomTextField({
    super.key,
    required this.hintText,
    this.suffixIconPath,
    this.controller,
    this.onChanged,
    this.onFieldSubmitted,
    this.onSave,
    this.errorText,
    this.suffixIconTap,
    this.maxLines,
    this.autoFocus = false,
    this.radius,
    this.validator,
    this.readOnly = false,
    this.keyboardType,
    this.textInputAction,
    this.prefixIcon,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorRadius: const Radius.circular(20),
      maxLength: maxLength,
      textInputAction: textInputAction,
      keyboardType: keyboardType,
      readOnly: readOnly,
      validator: validator,
      autofocus: autoFocus!,
      maxLines: maxLines ?? 1,
      controller: controller,
      onSaved: (String? value) {
        if (onSave != null) {
          onSave!(value);
        }
      },
      onFieldSubmitted: (String value) {
        if (onFieldSubmitted != null) {
          onFieldSubmitted!(value);
        }
      },
      onChanged: (String value) {
        if (onChanged != null) {
          onChanged!(value);
        }
      },
      decoration: InputDecoration(
        counterText: '',
        prefixIcon: prefixIcon,
        filled: true,
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        errorText: errorText,
        suffixIcon: suffixIconPath != null
            ? InkWell(
                onTap: () {
                  suffixIconTap!();
                },
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: SvgPicture.asset(
                    suffixIconPath!,
                  ),
                ),
              )
            : null,
      ),
    );
  }
}
