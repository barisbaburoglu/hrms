import 'package:flutter/material.dart';
import 'package:hrms/constants/colors.dart';

class BaseButton extends StatelessWidget {
  final double? width;
  final Color? backgroundColor;
  final Color? textColor;
  final Widget? icon;
  final String label;
  final Function()? onPressed;

  const BaseButton({
    super.key,
    this.width,
    this.backgroundColor,
    this.textColor,
    this.icon,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 125,
      child: MaterialButton(
        color: backgroundColor ?? AppColor.primaryAppColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: TextStyle(
                color: textColor ?? AppColor.secondaryText,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              softWrap: true,
              textAlign: TextAlign.center,
            ),
            icon != null ? const SizedBox(width: 5) : const SizedBox.shrink(),
            icon ?? const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
