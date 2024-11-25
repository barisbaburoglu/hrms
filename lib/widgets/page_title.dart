import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../constants/dimensions.dart';

class PageTitleWidget extends StatelessWidget {
  final String title;
  final Widget? rightWidgets;

  const PageTitleWidget({
    super.key,
    required this.title,
    this.rightWidgets,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColor.cardBackgroundColor,
      shadowColor: AppColor.cardShadowColor,
      margin: const EdgeInsets.all(AppDimension.kSpacing),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppDimension.kSpacing),
        child: Wrap(
          spacing: AppDimension.kSpacing,
          runSpacing: AppDimension.kSpacing,
          alignment: WrapAlignment.spaceBetween,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            rightWidgets ?? const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
