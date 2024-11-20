import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../api/models/user_role_actions_model.dart';

class SidebarController extends GetxController {
  GetStorage storageBox = GetStorage();

  RxInt selectedIndex = 0.obs;

  var groupHover = {}.obs;

  void setGroupHover(bool isHovered, String group) {
    groupHover[group] = isHovered;
  }

  bool isGroupHovered(String group) {
    return groupHover[group] ?? false;
  }

  void setSelectedIndex(int index) {
    selectedIndex.value = index;
  }

  void navigateTo(String routeName, int index) {
    setSelectedIndex(index);
    Get.toNamed(routeName);
  }

  void logout() async {
    await storageBox.erase();
    Get.toNamed('/');
  }

  bool hasPermission(String requiredGrup) {
    final actions = getUserRoleActionsFromStorage();
    return actions.any((e) => e.grup == requiredGrup);
  }

  List<UserRoleActionsModel> getUserRoleActionsFromStorage() {
    final box = GetStorage();
    List<dynamic>? jsonList = box.read('userRoleActions');
    if (jsonList != null) {
      return jsonList
          .map((item) => UserRoleActionsModel.fromJson(item))
          .toList();
    }
    return [];
  }
}
