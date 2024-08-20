import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../api/api_provider.dart';
import '../api/models/login_model.dart';
import '../api/models/login_response.model.dart';
import '../constants/colors.dart';
import '../widgets/custom_snack_bar.dart';

class AuthController extends GetxController {
  GetStorage storageBox = GetStorage();

  TextEditingController userName = TextEditingController();
  TextEditingController password = TextEditingController();

  RxBool loader = false.obs;
  static RxBool isLoggedIn = false.obs;
  static RxString accessToken = "".obs;

  void checkUserStatus() async {
    String? storedToken;
    String? storedExpiration;
    String? storedRefreshToken;

    storedToken = storageBox.read('accessToken');
    storedExpiration = storageBox.read('expires');
    storedRefreshToken = storageBox.read('refreshToken');

    if (storedToken != null && storedExpiration != null) {
      DateTime expirationDate =
          DateTime.now().add(Duration(seconds: int.parse(storedExpiration)));
      if (DateTime.now().isAfter(expirationDate)) {
        isLoggedIn.value = false;
        Get.toNamed("/");
      } else {
        if (DateTime.now()
            .isAfter(expirationDate.subtract(const Duration(minutes: 59)))) {
          refreshToken(storedRefreshToken!);
          storedToken = storageBox.read('accessToken');
          storedExpiration = storageBox.read('expires');
          storedRefreshToken = storageBox.read('refreshToken');
        }
        accessToken.value = storedToken!;
        isLoggedIn.value = true;
      }
    } else {
      isLoggedIn.value = false;
      Get.toNamed("/signin");
    }
  }

  void onPressedLogin(LogInModel logInModel) async {
    loader.value = true;
    if (logInModel.email!.isNotEmpty && logInModel.password!.isNotEmpty) {
      try {
        LoginResponseModel response =
            await ApiProvider().authService.login(logInModel);
        accessToken.value = response.accessToken!;
        if (accessToken.value.isNotEmpty) {
          String expiresIn = response.expiresIn.toString();
          String accessToken = response.accessToken!;
          String refreshToken = response.refreshToken!;
          await storageBox.write('accessToken', accessToken);
          await storageBox.write('expiresIn', expiresIn);
          await storageBox.write('refreshToken', refreshToken);
          loader.value = false;
          kIsWeb ? Get.toNamed("/index") : Get.toNamed("/home");
        } else {}
      } on Exception catch (e) {
        loader.value = false;
        Get.showSnackbar(
          CustomGetBar(
            textColor: AppColor.secondaryText,
            message: "Hatalı İşlem $e",
            duration: const Duration(seconds: 3),
            iconData: Icons.error,
            backgroundColor: AppColor.primaryRed,
          ),
        );
      }
    } else {
      loader.value = false;
      Get.showSnackbar(
        CustomGetBar(
          textColor: AppColor.secondaryText,
          message: "Lütfen boş alanları doldurun.",
          duration: Duration(seconds: 3),
          iconData: Icons.warning,
          backgroundColor: AppColor.primaryOrange,
        ),
      );
    }
  }

  void logout() async {
    await storageBox.erase();
    Get.toNamed('/');
  }

  void refreshToken(String refreshToken) async {
    if (refreshToken.isNotEmpty) {
      LoginResponseModel response =
          await ApiProvider().authService.refreshToken(refreshToken);

      accessToken.value = response.accessToken!;
      await storageBox.write('accessToken', response.accessToken);
    } else {
      Get.showSnackbar(
        CustomGetBar(
          textColor: AppColor.secondaryText,
          message: "Lütfen boş alanları doldurun.",
          duration: Duration(seconds: 3),
          iconData: Icons.warning,
          backgroundColor: AppColor.primaryOrange,
        ),
      );
    }
  }
}
