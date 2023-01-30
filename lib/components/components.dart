// Colors
import 'package:flutter/material.dart';

const kBackgroundColor = Color(0xFFD2FFF4);
const kPrimaryColor = Color(0xFF205070);
const kSecondaryColor = Color(0xFF2650AB);

String? uid;

Widget myTextFormField({
  @required controller,
  @required String? Function(String?)? validator,
  @required Function(dynamic value)? onFieldSubmitted,
  Widget? label,
  @required String? hintText,
  prefixIcon,
  suffixIcon,
  @required TextInputType? keyboardType,
  bool obscureText = false,
  Color? fillColor,
  bool filled = false,
  // double radius = 0.0,
  // @required int? maxLines,
}) =>
    TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      obscureText: obscureText,
      onFieldSubmitted: onFieldSubmitted,
      // maxLines: maxLines,
      decoration: InputDecoration(
        fillColor: fillColor,
        filled: filled,
        label: label,
        hintText: hintText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          // borderSide: BorderSide(color: Colors.orange),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          // borderSide: BorderSide.none,
        ),
      ),
    );
