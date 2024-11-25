import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hrms/constants/colors.dart';

class BaseInput extends StatelessWidget {
  final bool? errorRequired;
  final bool? readOnly;
  final String label;
  final TextEditingController controller;
  final EdgeInsetsGeometry? margin;
  final bool isLabel;
  final TextInputType textInputType;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String)? onChanged;
  final int? minLines;
  final int? maxLines;

  const BaseInput(
      {super.key,
      this.errorRequired,
      this.readOnly,
      this.onChanged,
      this.minLines,
      this.maxLines,
      required this.isLabel,
      required this.label,
      required this.controller,
      required this.margin,
      required this.textInputType,
      required this.inputFormatters});

  @override
  Widget build(BuildContext context) {
    final errorRequiredRx = (errorRequired ?? false).obs;
    final focusUserInputRx = false.obs;

    return Obx(() {
      return Container(
        margin: margin,
        child: SizedBox.expand(
          child: TextFormField(
            minLines: minLines ?? 1,
            maxLines: maxLines,
            readOnly: readOnly ?? false,
            onChanged: (value) {
              if (onChanged != null) {
                onChanged!(value);
              }
              if (errorRequired!) {
                errorRequiredRx.value = value.isEmpty;
              }
            },
            inputFormatters: inputFormatters,
            keyboardType: textInputType,
            cursorColor: AppColor.primaryAppColor,
            textAlign: TextAlign.left,
            style: const TextStyle(
              fontSize: 12,
              color: AppColor.primaryText,
              fontWeight: FontWeight.normal,
            ),
            controller: controller,
            autocorrect: false,
            enableSuggestions: false,
            autofocus: false,
            onTap: () {
              focusUserInputRx.value = true;
            },
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(10.0),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: errorRequiredRx.value
                      ? AppColor.primaryRed
                      : AppColor.primaryGrey,
                ),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide:
                    BorderSide(width: 1, color: AppColor.primaryAppColor),
                borderRadius: BorderRadius.all(
                  Radius.circular(0.0),
                ),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: errorRequiredRx.value
                      ? AppColor.primaryRed
                      : AppColor.primaryGrey,
                ),
              ),
              label: isLabel
                  ? FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        label,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColor.primaryText,
                          fontWeight: FontWeight.normal,
                        ),
                        textAlign: TextAlign.start,
                      ))
                  : null,
            ),
          ),
        ),
      );
    });
  }
}
