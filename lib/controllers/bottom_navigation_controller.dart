import 'package:get/get.dart';

class BottomNavigationController extends GetxController {
  var currentIndex = 2.obs;

  void changePage(int index) {
    currentIndex.value = index;
    switch (index) {
      case 0:
        Get.toNamed('/events');
        break;
      case 1:
        Get.toNamed('/parcel');
        break;
      case 2:
        Get.toNamed('/home');
        break;
      case 3:
        Get.toNamed('/home');
        break;
      case 4:
        Get.toNamed('/profile');
        break;
    }
  }
}
