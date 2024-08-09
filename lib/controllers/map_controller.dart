import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hrms/constants/colors.dart';

class MapController extends GetxController {
  final LatLng center = const LatLng(36.8902144, 30.695312);

  final List<LatLng> locations = [
    LatLng(36.8902144, 30.695312),
    LatLng(36.8912144, 30.696312),
    LatLng(36.8922144, 30.697312),
    LatLng(36.8932144, 30.698312),
    LatLng(36.8945144, 30.699312),
    LatLng(36.8952144, 30.700312),
  ];

  final RxSet<Marker> markers = <Marker>{}.obs;
  final RxSet<Polyline> polylines = <Polyline>{}.obs;

  late GoogleMapController mapController;

  @override
  void onInit() {
    super.onInit();
    _initializeMarkers();
  }

  Future<void> _initializeMarkers() async {
    for (int i = 0; i < locations.length; i++) {
      final markerIcon = await _getMarkerIcon('assets/images/avatar.png', 35);
      markers.add(
        Marker(
          markerId: MarkerId(locations[i].toString()),
          position: locations[i],
          icon: markerIcon,
          infoWindow: InfoWindow(
            title: 'Location ${i + 1}',
          ),
        ),
      );
    }

    // Polyline
    polylines.add(
      Polyline(
        polylineId: PolylineId('route'),
        points: locations,
        color: AppColor.mapPolylineColor,
        width: 5,
      ),
    );
  }

  Future<BitmapDescriptor> _getMarkerIcon(String assetPath, int size) async {
    final ByteData data = await rootBundle.load(assetPath);
    final Uint8List bytes = data.buffer.asUint8List();
    final ui.Codec codec =
        await ui.instantiateImageCodec(bytes, targetWidth: size);
    final ui.FrameInfo fi = await codec.getNextFrame();
    final ui.Image image = fi.image;

    final ui.PictureRecorder recorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(recorder);

    final Paint paint = Paint()..isAntiAlias = true;
    final double radius = size / 2;

    canvas.drawCircle(Offset(radius, radius), radius, paint);
    paint.blendMode = BlendMode.srcIn;
    canvas.drawImageRect(
      image,
      Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble()),
      Rect.fromLTWH(0, 0, size.toDouble(), size.toDouble()),
      paint,
    );

    final ui.Image circledImage =
        await recorder.endRecording().toImage(size, size);
    final ByteData? byteData =
        await circledImage.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List resizedBytes = byteData!.buffer.asUint8List();
    return BitmapDescriptor.fromBytes(resizedBytes);
  }

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }
}
