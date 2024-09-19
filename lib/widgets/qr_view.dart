import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrms/controllers/home_controller.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrScannerView extends StatelessWidget {
  final HomeController qrScannerController = Get.put(HomeController());

  QrScannerView({super.key});

  @override
  Widget build(BuildContext context) {
    double scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 250.0
        : 400.0;

    return QRView(
      key: qrScannerController.qrKey,
      onQRViewCreated: qrScannerController.onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.green,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: qrScannerController.onPermissionSet,
    );
  }
}
