import 'package:flutter/material.dart';
import 'package:hrms/constants/colors.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../constants/dimensions.dart';

class ColorfulQrCode extends StatelessWidget {
  final String? data;
  final int eventTypeId;
  final double? size;

  const ColorfulQrCode({
    super.key,
    this.data,
    required this.eventTypeId,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    Color color =
        eventTypeId == 1 ? AppColor.primaryGreen : AppColor.primaryRed;
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
        : QrImageView(
            data: data!,
            version: QrVersions.auto,
            size: size ?? 200,
            gapless: false,
            // embeddedImage: const AssetImage('assets/images/entry.png'),
            // embeddedImageStyle: const QrEmbeddedImageStyle(
            //     size: Size(80, 80), color: Colors.white),
            eyeStyle: QrEyeStyle(
              eyeShape: QrEyeShape.square,
              color: color,
            ),
            dataModuleStyle: QrDataModuleStyle(
              dataModuleShape: QrDataModuleShape.square,
              color: color,
            ),
          );
  }
}
