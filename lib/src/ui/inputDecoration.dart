import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

class InputDecorations {
  static InputDecoration authInputDecoration(
      {required String hintText,
      required String labelText,
      SvgPicture? prefixIcon}) {
    return InputDecoration(
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 2)),
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.grey),
        labelText: labelText,
        labelStyle: const TextStyle(color: Colors.grey),
        prefixIcon: prefixIcon != null
            ? Container(
                margin: const EdgeInsets.only(right: 10, bottom: 10, top: 10),
                child: prefixIcon)
            : null);
  }

  static InputDecoration calendarInputDecoration({
    required String labelText,
  }) {
    return InputDecoration(
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: Color(0xffB5B5B4)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: Color(0xff00003D)),
      ),
      labelText: labelText,
      labelStyle: const TextStyle(color: Color(0xffB5B5B4), fontSize: 15),
      floatingLabelAlignment: FloatingLabelAlignment.start,
      alignLabelWithHint: true,
    );
  }
}
