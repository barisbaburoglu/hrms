import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hrms/api/models/login_model.dart';
import 'package:hrms/controllers/auth_controller.dart';
import 'package:hrms/widgets/base_input.dart';

import '../constants/colors.dart';
import '../widgets/base_button.dart';

class SignInPage extends StatelessWidget {
  final AuthController controller = Get.put(AuthController());

  SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.canvasColor,
      body: Obx(
        () => Stack(
          children: [
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 600,
                    width: 350,
                    color: AppColor.canvasColor,
                    // decoration: const BoxDecoration(
                    //   image: DecorationImage(
                    //       image: AssetImage('assets/images/bg.jpeg'), fit: BoxFit.fill),
                    // ),
                    alignment: Alignment.center,
                    child: Container(
                      height: 400,
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(horizontal: 30),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(15),
                        color: AppColor.primaryAppColor.withOpacity(0.25),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaY: 5, sigmaX: 5),
                            child: Padding(
                              padding: const EdgeInsets.all(25),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Spacer(),
                                  const Center(
                                      child: Text(
                                    "GİRİŞ",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54,
                                      letterSpacing: 1.5,
                                    ),
                                  )),
                                  const Spacer(),
                                  SizedBox(
                                    width: 310,
                                    height: 60,
                                    child: BaseInput(
                                        isLabel: true,
                                        label: "Kullanıcı Adı",
                                        controller: controller.userName,
                                        margin: EdgeInsets.zero,
                                        textInputType: TextInputType.text,
                                        inputFormatters: []),
                                  ),
                                  const Spacer(),
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
                                        inputFormatters: []),
                                  ),
                                  const Spacer(),
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
                                  const Spacer(),
                                  const Center(
                                      child: Text(
                                    "Henüz kayıt olmadıysan KAYIT OL",
                                  )),
                                  const Spacer(),
                                ],
                              ),
                            )),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: controller.loader.value,
              child: SizedBox.expand(
                child: Container(
                  color: Colors.black.withOpacity(0.25),
                  child: Center(
                      child: SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 5,
                          ))),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
