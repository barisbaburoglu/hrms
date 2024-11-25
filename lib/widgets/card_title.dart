import 'package:flutter/material.dart';
import '../constants/colors.dart';

class CardTitle extends StatelessWidget {
  final String? title;
  final Widget? leftWidgets;
  final Widget? rightWidgets;

  const CardTitle({
    super.key,
    this.title,
    this.leftWidgets,
    this.rightWidgets,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (leftWidgets != null) leftWidgets!,
              if (title != null)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text(
                      title!,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              if (rightWidgets != null) rightWidgets!,
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
