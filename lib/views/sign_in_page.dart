import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hrms/api/models/login_model.dart';
import 'package:hrms/controllers/auth_controller.dart';
import 'package:hrms/widgets/base_input.dart';

import '../constants/colors.dart';
import '../widgets/base_button.dart';
import '../widgets/custom_snack_bar.dart';

class SignInPage extends StatelessWidget {
  final AuthController controller = Get.put(AuthController());

  SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.canvasColor,
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Ekran genişliği kontrolü
          double screenWidth = constraints.maxWidth;
          double width = screenWidth > 860 ? 745 : 390;
          double height = 390;
          double sizeSplitPart = 350;

          return Obx(
            () => Stack(
              children: [
                Center(
                  child: SizedBox(
                    width: width,
                    height: height,
                    child: Card(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      shadowColor: Colors.black,
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            mainAxisAlignment: screenWidth > 860
                                ? MainAxisAlignment.spaceBetween
                                : MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              if (screenWidth > 860)
                                SizedBox(
                                  width: sizeSplitPart,
                                  height: sizeSplitPart,
                                  child: Card(
                                    shape: const RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5)),
                                    ),
                                    shadowColor: Colors.black,
                                    child: Image.asset(
                                      'assets/images/loginai.png',
                                      fit: BoxFit.cover,
                                      width: 390,
                                      height: 390,
                                    ),
                                  ),
                                ),
                              SizedBox(
                                width: sizeSplitPart,
                                height: sizeSplitPart,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/images/logolight.png',
                                      fit: BoxFit.cover,
                                      width: 200,
                                    ),
                                    const SizedBox(height: 15),
                                    const Text(
                                      'Giriş',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: AppColor.primaryAppColor,
                                        letterSpacing: 1.5,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 15),
                                    SizedBox(
                                      width: 310,
                                      height: 60,
                                      child: BaseInput(
                                        isLabel: true,
                                        label: "Kullanıcı Adı",
                                        controller: controller.userName,
                                        margin: EdgeInsets.zero,
                                        textInputType: TextInputType.text,
                                        inputFormatters: [],
                                      ),
                                    ),
                                    const SizedBox(height: 15),
                                    SizedBox(
                                      width: 310,
                                      height: 60,
                                      child: BaseInput(
                                        isLabel: true,
                                        label: "Şifre",
                                        controller: controller.password,
                                        margin: EdgeInsets.zero,
                                        textInputType:
                                            TextInputType.visiblePassword,
                                        inputFormatters: [],
                                      ),
                                    ),
                                    const SizedBox(height: 15),
                                    SizedBox(
                                      width: 310,
                                      child: BaseButton(
                                        label: "Giriş Yap",
                                        icon: const Icon(
                                          Icons.login,
                                          color: AppColor.secondaryText,
                                        ),
                                        onPressed: () {
                                          LogInModel loginModel = LogInModel();
                                          loginModel.email =
                                              controller.userName.text;
                                          loginModel.password =
                                              controller.password.text;

                                          controller.onPressedLogin(loginModel);
                                        },
                                      ),
                                    ),
                                    const SizedBox(height: 15),
                                    Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Text(
                                            "Henüz Kayıt olmadınız mı?",
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                          TextButton(
                                            child: const Text(
                                              "Kayıt Ol",
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                height: 2,
                                                decoration:
                                                    TextDecoration.underline,
                                                decorationColor:
                                                    AppColor.primaryAppColor,
                                              ),
                                            ),
                                            onPressed: () {
                                              Get.showSnackbar(
                                                CustomGetBar(
                                                  textColor:
                                                      AppColor.secondaryText,
                                                  message:
                                                      "Çok Yakında Hizmetinizdeyiz!",
                                                  duration: const Duration(
                                                      seconds: 3),
                                                  iconData: Icons
                                                      .notification_important_outlined,
                                                  backgroundColor:
                                                      AppColor.primaryOrange,
                                                ),
                                              );
                                            },
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: controller.loader.value,
                  child: SizedBox.expand(
                    child: Container(
                      color: Colors.black.withOpacity(0.25),
                      child: const Center(
                        child: SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 5,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
