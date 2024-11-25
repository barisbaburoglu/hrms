import 'package:flutter/material.dart';
import 'package:hrms/constants/colors.dart';
import 'package:hrms/constants/dimensions.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRCodeDisplay extends StatelessWidget {
  final String? data;

  const QRCodeDisplay({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return data == null
        ? SizedBox(
            width: 250,
            height: 250,
            child: Card(
              color: AppColor.cardBackgroundColor,
              shadowColor: AppColor.cardShadowColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: const Padding(
                padding: EdgeInsets.all(AppDimension.kSpacing),
                child: Center(
                  child: Text(
                    "Bilgileri doldurup kaydettikten sonra karekodu buradan indirebilirsiniz.",
                    maxLines: 4,
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          )
        : SizedBox(
            width: 250,
            height: 250,
            child: QrImageView(
              data: data!,
              version: QrVersions.auto,
              size: 200.0,
            ),
          );
  }
}
