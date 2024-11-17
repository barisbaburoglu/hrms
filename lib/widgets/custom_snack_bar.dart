import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrms/constants/dimensions.dart';

class CustomGetBar extends GetSnackBar {
  final String message;
  final Duration duration;
  final IconData iconData;
  final Color backgroundColor;
  final Color textColor;

  CustomGetBar({
    super.key,
    required this.message,
    required this.duration,
    required this.iconData,
    required this.backgroundColor,
    required this.textColor,
  }) : super(
          snackPosition: SnackPosition.TOP,
          messageText: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                iconData,
                size: 25,
                color: textColor,
              ),
              const SizedBox(width: AppDimension.kSpacing / 2),
              Text(
                message,
                style: TextStyle(color: textColor),
              ),
            ],
          ),
          duration: duration,
          backgroundColor: backgroundColor,
          barBlur: 20,
          isDismissible: true,
          borderRadius: 5,
          margin: const EdgeInsets.all(AppDimension.kSpacing / 2),
          boxShadows: [
            const BoxShadow(
              color: Colors.black38,
              offset: Offset(0, 2),
              blurRadius: 3.0,
            )
          ],
        );
}
