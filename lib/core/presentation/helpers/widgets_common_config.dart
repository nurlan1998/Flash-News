import 'package:flutter/material.dart';

import 'app_colors.dart';

class WidgetsCommonConfig {
  static final BoxDecoration withShadow = BoxDecoration(
    color: Colors.white,
    boxShadow: <BoxShadow>[
      BoxShadow(
        color: Colors.grey[300]!,
        blurRadius: 1.0,
        offset: const Offset(0.0, 2.0),
      ),
    ],
  );

  static final BoxDecoration withShadowRounded = withShadow.copyWith(
    borderRadius: BorderRadius.circular(20.0),
  );

  static final BoxDecoration rounded = withShadow.copyWith(
    borderRadius: BorderRadius.circular(20.0),
    boxShadow: [],
  );

  static final BoxDecoration roundedBlue = withShadow.copyWith(
    borderRadius: BorderRadius.circular(20.0),
    border: Border.all(color: Colors.blue),
  );

  static const inputFocusedBorder = BorderSide(
    color: AppColors.primary,
    width: 1.0,
  );

  static const inputBorder = BorderSide(
    // color: Color(0xFFE0E0E0),
    width: 1.0,
  );

  /*static final InputDecoration baseInputDecoration = InputDecoration(
    labelStyle: TextStyle(fontSize: 18.0),
    floatingLabelBehavior: FloatingLabelBehavior.auto,
    fillColor: Colors.white,
    filled: true,
    focusedBorder: UnderlineInputBorder(
      borderSide: inputFocusedBorder,
    ),
    border: UnderlineInputBorder(
      borderSide: inputBorder,
    ),
    enabledBorder: UnderlineInputBorder(
      borderSide: inputBorder,
    ),
    errorBorder: UnderlineInputBorder(
      borderSide: inputBorder,
    ),
  );*/

  static final InputDecoration baseInputDecoration = InputDecoration(
    labelStyle: const TextStyle(fontSize: 16.0),
    floatingLabelBehavior: FloatingLabelBehavior.auto,
    //fillColor: Colors.white,
    filled: true,
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: inputFocusedBorder,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: inputBorder,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: inputBorder,
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: inputBorder,
    ),
    errorStyle: TextStyle(
      color: Colors.red, // or any other color
    ),
  );

  static final InputDecoration underlineInputDecoration =
  baseInputDecoration.copyWith(
    focusedBorder: const UnderlineInputBorder(
      borderSide: inputFocusedBorder,
    ),
    border: const UnderlineInputBorder(
      borderSide: inputBorder,
    ),
    enabledBorder: const UnderlineInputBorder(
      borderSide: inputBorder,
    ),
    errorBorder: const UnderlineInputBorder(
      borderSide: inputBorder,
    ),
  );

  static final InputDecoration baseDropdownDecoration =
  baseInputDecoration.copyWith(
    contentPadding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
  );
}
