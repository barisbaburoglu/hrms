import 'package:flutter/material.dart';
import 'package:hrms/constants/colors.dart';

final ScrollbarThemeData customScrollbarTheme = ScrollbarThemeData(
  thumbVisibility: const WidgetStatePropertyAll(true),
  thumbColor:
      WidgetStateProperty.all(AppColor.primaryAppColor.withOpacity(0.5)),
  trackColor: WidgetStateProperty.all(AppColor.primaryAppColor),
  radius: Radius.zero,
  thickness: WidgetStateProperty.all(5.0),
);
