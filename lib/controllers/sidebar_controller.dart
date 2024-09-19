import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SidebarController extends GetxController {
  GetStorage storageBox = GetStorage();

  void navigateTo(String routeName, int index) {
    Get.toNamed(routeName);
  }

  void logout() async {
    await storageBox.erase();
    Get.toNamed('/');
  }
}
