import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrms/controllers/shift_controller.dart';
import 'package:hrms/widgets/base_button.dart';
import 'package:hrms/widgets/base_input.dart';
import 'package:intl/intl.dart';
import '../api/models/shift_day_model.dart';
import '../api/models/shift_model.dart';
import '../constants/colors.dart';
import '../constants/dimensions.dart';

class EditFormShift extends StatelessWidget {
  final String title;
  final Shift? shift;
  final ShiftController controller = Get.put(ShiftController());

  EditFormShift({
    super.key,
    required this.title,
    this.shift,
  });

  @override
  Widget build(BuildContext context) {
    double inputWidth = kIsWeb ? 310 : double.infinity;
    double screenWidth = MediaQuery.of(Get.context!).size.width;

    if (shift != null) {
      // controller.setCompanyFields(shift!);
    } else {
      //controller.clearCompanyFields();
    }

    return SizedBox(
      width: kIsWeb ? 740 : double.infinity,
      height: 700,
      child: Card(
        color: AppColor.cardBackgroundColor,
        shadowColor: AppColor.cardShadowColor,
        margin: const EdgeInsets.all(AppDimension.kSpacing),
        child: Padding(
          padding: const EdgeInsets.all(AppDimension.kSpacing / 2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(AppDimension.kSpacing / 2),
                    child: Divider(
                      height: 1,
                      color: AppColor.primaryAppColor.withOpacity(0.25),
                    ),
                  ),
                  Wrap(
                    alignment: WrapAlignment.start,
                    spacing: AppDimension.kSpacing,
                    runSpacing: AppDimension.kSpacing,
                    children: [
                      SizedBox(
                        width: inputWidth,
                        height: 40,
                        child: BaseInput(
                          isLabel: true,
                          errorRequired: false,
                          label: "Çalışma Takvimi Adı",
                          controller: controller.nameController,
                          margin: EdgeInsets.zero,
                          textInputType: TextInputType.text,
                          inputFormatters: const [],
                          onChanged: (value) {},
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: AppDimension.kSpacing / 2,
                  ),
                  SizedBox(
                    height: 400,
                    child: Obx(() {
                      return ListView.builder(
                        itemCount: controller.shiftDays.length,
                        itemBuilder: (context, index) {
                          ShiftDay shiftDay = controller.shiftDays[index];

                          return Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5.0, horizontal: 5.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Gün adı (Label)
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        controller.daysOfWeek[index],
                                        style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),

                                    // Is Off Day (Checkbox)
                                    Expanded(
                                      flex: 2,
                                      child: Column(
                                        children: [
                                          index == 0
                                              ? Text(
                                                  "Off Day",
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                              : const SizedBox.shrink(),
                                          Checkbox(
                                            value: shiftDay.isOffDay,
                                            onChanged: (bool? value) {
                                              controller.shiftDays[index] =
                                                  shiftDay.copyWith(
                                                      isOffDay: value ?? false);
                                            },
                                          ),
                                        ],
                                      ),
                                    ),

                                    // Start Time (TimePicker)
                                    Expanded(
                                      flex: 2,
                                      child: SizedBox(
                                        width: 75,
                                        height: 40,
                                        child: _buildStartTimePicker(
                                            index, shiftDay.startTime!),
                                      ),
                                    ),
                                    const Expanded(
                                      flex: 1,
                                      child: SizedBox.shrink(),
                                    ),

                                    // End Time (TimePicker)
                                    Expanded(
                                      flex: 2,
                                      child: SizedBox(
                                        width: 75,
                                        height: 40,
                                        child: _buildEndTimePicker(
                                            index, shiftDay.endTime!),
                                      ),
                                    ),

                                    const Expanded(
                                      flex: 1,
                                      child: SizedBox.shrink(),
                                    ),

                                    // Duration (Textbox - read only)
                                    Expanded(
                                      flex: 2,
                                      child: SizedBox(
                                        width: inputWidth,
                                        height: 40,
                                        child: BaseInput(
                                          isLabel: true,
                                          errorRequired: false,
                                          label: "Çalışma Saati",
                                          controller: TextEditingController(
                                              text:
                                                  controller.calculateDuration(
                                                      shiftDay.startTime!,
                                                      shiftDay.endTime!)),
                                          margin: EdgeInsets.zero,
                                          textInputType: TextInputType.text,
                                          inputFormatters: const [],
                                          onChanged: (value) {},
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                height: 1,
                                color:
                                    AppColor.primaryAppColor.withOpacity(0.25),
                              )
                            ],
                          );
                        },
                      );
                    }),
                  ),
                ],
              ),
              Wrap(
                alignment: WrapAlignment.center,
                runSpacing: AppDimension.kSpacing,
                spacing: AppDimension.kSpacing,
                children: [
                  BaseButton(
                    width: screenWidth < 360 ? double.infinity : 125,
                    backgroundColor: AppColor.primaryRed,
                    label: "Vazgeç",
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(
                      Icons.close,
                      color: AppColor.secondaryText,
                    ),
                  ),
                  BaseButton(
                    width: screenWidth < 360 ? double.infinity : 125,
                    label: "Kaydet",
                    onPressed: () {
                      controller.saveShift(shift: shift);
                    },
                    icon: const Icon(
                      Icons.save,
                      color: AppColor.secondaryText,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStartTimePicker(int index, String startTime) {
    // TextEditingController'ı widget seviyesinde tek seferde oluşturuyoruz.
    final TextEditingController _controller = TextEditingController(
      text: startTime, // İlk başlama zamanını burada veriyoruz
    );

    return GestureDetector(
      onTap: () async {
        TimeOfDay? pickedTime = await controller.selectTime(
          Get.context!,
          TimeOfDay.fromDateTime(
            DateFormat('HH:mm').parse(startTime),
          ),
        );

        if (pickedTime != null) {
          // Seçilen saati 24 saatlik formatta göster
          final localizations = MaterialLocalizations.of(Get.context!);
          String formattedTime = localizations.formatTimeOfDay(
            pickedTime,
            alwaysUse24HourFormat: true,
          );

          // Zamanı kontrolcüye güncelle
          controller.updateShiftTime(
            index,
            formattedTime, // Başlama saatini güncelle
            controller.shiftDays[index].endTime!, // Mevcut bitiş saatini tut
          );

          // TextEditingController'daki metni güncelle
          _controller.text = formattedTime;
        }
      },
      child: AbsorbPointer(
        child: BaseInput(
          label: "Başlama Saati",
          controller:
              _controller, // Burada controller'a ilk değeri set ediyoruz
          isLabel: true,
          errorRequired: false,
          margin: EdgeInsets.zero,
          textInputType: TextInputType.text,
          inputFormatters: const [],
          onChanged: (value) {
            // Bu alan artık gerektiğinde zaman değeriyle güncelleniyor.
          },
        ),
      ),
    );
  }

  Widget _buildEndTimePicker(int index, String endTime) {
    // TextEditingController'ı widget seviyesinde tek seferde oluşturuyoruz.
    final TextEditingController _controller = TextEditingController(
      text: endTime, // İlk başlama zamanını burada veriyoruz
    );

    return GestureDetector(
      onTap: () async {
        TimeOfDay? pickedTime = await controller.selectTime(
          Get.context!,
          TimeOfDay.fromDateTime(
            DateFormat('HH:mm').parse(endTime),
          ),
        );

        if (pickedTime != null) {
          // Seçilen saati 24 saatlik formatta göster
          final localizations = MaterialLocalizations.of(Get.context!);
          String formattedTime = localizations.formatTimeOfDay(
            pickedTime,
            alwaysUse24HourFormat: true,
          );

          // Zamanı kontrolcüye güncelle
          controller.updateShiftTime(
            index,
            controller.shiftDays[index].startTime!,
            formattedTime, // 24 saatlik formatta gösterim
          );

          // TextEditingController'daki metni güncelle
          _controller.text = formattedTime;
        }
      },
      child: AbsorbPointer(
        child: BaseInput(
          label: "Bitiş Saati",
          controller:
              _controller, // Burada controller'a ilk değeri set ediyoruz
          isLabel: true,
          errorRequired: false,
          margin: EdgeInsets.zero,
          textInputType: TextInputType.text,
          inputFormatters: const [],
          onChanged: (value) {
            // Bu alan artık gerektiğinde zaman değeriyle güncelleniyor.
          },
        ),
      ),
    );
  }
}
