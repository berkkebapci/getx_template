// ignore_for_file: library_prefixes, deprecated_member_use, depend_on_referenced_packages

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_template/shared/uicolor.dart';
import 'package:getx_template/shared/uipath.dart';
import 'package:getx_template/widgets/widget_buttons.dart';
import 'package:getx_template/widgets/widget_text.dart';

showAlertDialogSuccess(String text, String desc) {
  Get.dialog(
    BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: AlertDialog(
        title: Image.asset(
          UIPath.success,
          height: 80,
        ),
        content: SizedBox(
          height: desc.length > 40 ? 220 : 180,
          child: Column(
            children: [
              TextBasic(
                text: text,
                color: UIColor.success,
                fontSize: 20,
                fontWeight: FontWeight.w600,
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: TextBasic(
                  text: desc,
                  textAlign: TextAlign.center,
                  color: UIColor.mirage,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 24),
              ButtonBasic(
                buttonText: "Geri",
                bgGradientColor: UIGradient.primaryGradient,
                radius: 6,
                onTap: () {
                  Get.back();
                },
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    ),
  );
}

showAlertDialogSuccessWithButton(String text, String desc, Widget? page, String buttonText) {
  Get.dialog(
    BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: AlertDialog(
        title: Image.asset(
          UIPath.success,
          height: 80,
        ),
        content: SizedBox(
          height: desc.length > 40 ? 240 : 180,
          child: Column(
            children: [
              TextBasic(
                text: text,
                color: UIColor.success,
                fontSize: 20,
                fontWeight: FontWeight.w600,
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                child: TextBasic(
                  text: desc,
                  textAlign: TextAlign.center,
                  color: UIColor.mirage,
                  fontSize: 14,
                ),
              ),
              ButtonBasic(
                buttonText: buttonText,
                bgGradientColor: UIGradient.primaryGradient,
                radius: 6,
                onTap: () {
                  if (page != null) {
                    Get.offAll(() => page);
                  }
                  Get.back();
                },
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    ),
  );
}

showAlertDialogWithButton(String text, String desc, Widget? page, Function() onTap) {
  Get.dialog(
    BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        content: SizedBox(
          height: 180,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Başlık
              TextBasic(
                text: text,
                color: UIColor.success,
                fontSize: 20,
                fontWeight: FontWeight.w600,
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                child: Text(
                  desc,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: UIColor.mirage,
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: UIColor.success),
                      ),
                      child: TextBasic(
                        text: "Hayır",
                        color: UIColor.success,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  GestureDetector(
                    onTap: () async {
                      await onTap();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        color: UIColor.success,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const TextBasic(
                        text: "Evet",
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

showAlertDialogFailed(String text, String desc) async {
  await Get.dialog(
    BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: AlertDialog(
        title: Image.asset(
          UIPath.failed,
          height: 80,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextBasic(
              text: text,
              color: UIColor.red,
              fontSize: 20,
              fontWeight: FontWeight.w600,
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: TextBasic(
                text: desc,
                textAlign: TextAlign.center,
                color: UIColor.mirage,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 36),
            ButtonBasic(
              buttonText: "Tekrar Deneyin",
              bgGradientColor: UIGradient.primaryGradient,
              radius: 6,
              onTap: () {
                Get.back();
              },
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    ),
  );
}

showAlertDialogFailedwithButton(String text, String desc, Function() onTap) async {
  await Get.dialog(
    barrierDismissible: false,
    PopScope(
      canPop: false,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: AlertDialog(
          title: Image.asset(
            UIPath.failed,
            height: 80,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextBasic(
                text: text,
                color: UIColor.red,
                fontSize: 20,
                fontWeight: FontWeight.w600,
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: TextBasic(
                  text: desc,
                  textAlign: TextAlign.center,
                  color: UIColor.mirage,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 36),
              ButtonBasic(
                  buttonText: "Anasayfaya Dön",
                  bgGradientColor: UIGradient.primaryGradient,
                  radius: 6,
                  onTap: () async {
                    await onTap();
                  }),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    ),
  );
}
