import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';
import 'package:sidebarx/sidebarx.dart';
import '../controllers/map_controller.dart';
import 'master_scaffold.dart';

class MapPage extends StatelessWidget {
  final MapController controller = Get.put(MapController());

  final SidebarXController sidebarController =
      SidebarXController(selectedIndex: 6, extended: true);

  MapPage({super.key});
  @override
  Widget build(BuildContext context) {
    return MasterScaffold(
      sidebarController: sidebarController,
      body: Obx(() => GoogleMap(
            onMapCreated: controller.onMapCreated,
            initialCameraPosition: CameraPosition(
              target: controller.center,
              zoom: 13.0,
            ),
            markers: controller.markers.toSet(),
            polylines: controller.polylines.toSet(),
          )),
    );
  }
}
