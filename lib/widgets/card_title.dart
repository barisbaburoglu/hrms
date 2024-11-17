import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../constants/dimensions.dart';

class CardTitle extends StatelessWidget {
  final String title;
  final Widget? rightWidgets;

  const CardTitle({
    super.key,
    required this.title,
    this.rightWidgets,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: AppDimension.kSpacing),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              rightWidgets ?? const SizedBox.shrink(),
            ],
          ),
        ),
        const Divider(
          height: 5,
          thickness: 3,
          color: AppColor.canvasColor,
        ),
      ],
    );
  }
}
