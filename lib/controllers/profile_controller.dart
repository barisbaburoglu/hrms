import 'package:get/get.dart';

class ProfileController extends GetxController {
  var profileImageUrl = 'https://example.com/profile.jpg'.obs;
  var email = 'example@example.com'.obs;
  var phoneNumber = '+1234567890'.obs;

  void updateProfileImage(String newImageUrl) {
    profileImageUrl.value = newImageUrl;
  }

  void updateEmail(String newEmail) {
    email.value = newEmail;
  }

  void updatePhoneNumber(String newPhoneNumber) {
    phoneNumber.value = newPhoneNumber;
  }

  void changePassword(String newPassword) {}
}
