import 'package:flutter/material.dart';
import 'package:hrms/constants/colors.dart';

final CheckboxThemeData customCheckboxTheme = CheckboxThemeData(
  checkColor: WidgetStateProperty.resolveWith(
    (states) {
      if (states.contains(WidgetState.selected)) {
        return AppColor.primaryAppColor;
      }
      return Colors.transparent;
    },
  ),
  side: const BorderSide(color: Colors.grey),
  fillColor: WidgetStateProperty.resolveWith(
    (states) {
      return Colors.transparent;
    },
  ),
);
