import 'package:get/get.dart';

class BottomNavigationController extends GetxController {
  var currentIndex = 2.obs;

  void changePage(int index) {
    currentIndex.value = index;
    switch (index) {
      case 0:
        Get.toNamed('/map');
        break;
      case 1:
        Get.toNamed('/location-qr');
        break;
      case 2:
        Get.toNamed('/');
        break;
      case 3:
        Get.toNamed('/');
        break;
      case 4:
        Get.toNamed('/');
        break;
    }
  }
}
