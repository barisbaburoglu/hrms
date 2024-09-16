import 'package:get/get.dart';

class ProfileController extends GetxController {
  var profileImageUrl = 'https://example.com/profile.jpg'.obs;
  var email = 'example@example.com'.obs;
  var phoneNumber = '+1234567890'.obs;

  // Profil resmi değiştirme metodu
  void updateProfileImage(String newImageUrl) {
    profileImageUrl.value = newImageUrl;
  }

  // Mail güncelleme metodu
  void updateEmail(String newEmail) {
    email.value = newEmail;
  }

  // Telefon numarası güncelleme metodu
  void updatePhoneNumber(String newPhoneNumber) {
    phoneNumber.value = newPhoneNumber;
  }

  // Şifre yenileme metodu
  void changePassword(String newPassword) {
    // Şifre yenileme işlemi
  }
}
