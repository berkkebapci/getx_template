// ignore_for_file: depend_on_referenced_packages

import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_template/controllers/controller_user_auth/controller_login.dart';
import 'package:getx_template/shared/uicolor.dart';
import 'package:getx_template/shared/uipath.dart';
import 'package:getx_template/views/view_user_auth/view_register.dart';
import 'package:getx_template/widgets/widget_activity_indicator.dart';
import 'package:getx_template/widgets/widget_alert_dialog.dart';
import 'package:getx_template/widgets/widget_buttons.dart';
import 'package:getx_template/widgets/widget_text.dart';
import 'package:getx_template/widgets/widget_textfield.dart';
import 'package:upgrader/upgrader.dart';

class ViewLogin extends StatelessWidget {
  ViewLogin({super.key});
  final ControllerLogin c = Get.put(ControllerLogin());

  @override
  Widget build(BuildContext context) {
    return Obx(() => UpgradeAlert(
          upgrader: Upgrader(
            minAppVersion: c.latestVersion.value,
            debugDisplayAlways: true,
            messages: UpgraderMessages(code: 'tr'),
          ),
          dialogStyle: Platform.isAndroid ? UpgradeDialogStyle.material : UpgradeDialogStyle.cupertino,
          showIgnore: c.forceUpdate.value,
          showLater: false,
          child: Scaffold(
            backgroundColor: UIColor.white,
            body: getBody(context),
          ),
        ));
  }

  Widget getBody(BuildContext context) {
    return c.busy == true
        ? const WidgetActivityIndicator()
        : SingleChildScrollView(
            physics: const ScrollPhysics(),
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [getImage(), getLogin()],
            ),
          );
  }

  Widget getImage() {
    return Container(
      height: Get.height,
      padding: const EdgeInsets.only(top: 80),
      decoration: BoxDecoration(
        color: UIColor.primary,
      ),
      child: Align(
        alignment: Alignment.topCenter,
        child: Image.asset(
          UIPath.logo,
          height: 100,
        ),
      ),
    );
  }

  Widget getLogin() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const SizedBox(height: 20),
          const Align(
            alignment: Alignment.centerLeft,
            child: TextBasic(
              text: "Giriş Yap",
              isItalic: true,
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 20),
          BasicTextField(
            hint: "Mail Adresi",
            textCapitalization: TextCapitalization.none,
            controller: c.emailController,
            keyboardType: TextInputType.emailAddress,
          ),
          Obx(
            () => Padding(
              padding: const EdgeInsets.only(top: 12, bottom: 8),
              child: BasicTextField(
                hint: "Şifre",
                keyboardType: TextInputType.visiblePassword,
                textCapitalization: TextCapitalization.none,
                controller: c.passwordController,
                obscureText: c.isVisible.value,
                suffixIcon: GestureDetector(
                    onTap: () {
                      c.isVisible.value == true ? c.setVisible(false) : c.setVisible(true);
                    },
                    child: c.isVisible.value == true ? const Icon(Icons.visibility) : const Icon(Icons.visibility_off)),
              ),
            ),
          ),
          Row(
            children: [
              CupertinoCheckbox(
                activeColor: UIColor.primary,
                value: c.isRemember.value,
                onChanged: ((value) {
                  c.setRemember(c.isRemember.value);
                }),
              ),
              const TextBasic(text: "Beni Hatırla"),
            ],
          ),
          GestureDetector(
            onTap: () {
              // Get.to(() => const ViewResetPassword());
            },
            child: const Align(
              alignment: Alignment.centerRight,
              child: TextBasic(
                text: "Şifre Sıfırlama",
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(height: 32),
          ButtonBasic(
            buttonText: "Giriş Yap",
            bgGradientColor: UIGradient.primaryGradient,
            onTap: () async {
              c.setBusy(true);
              if (c.emailController.text.isNotEmpty && c.passwordController.text.isNotEmpty) {
                final user = await c.signInWithEmailPassword(c.emailController.text, c.passwordController.text);
                log(user.toString());
              } else {
                showAlertDialogFailed("Lütfen Gerekli Alanları Doldurunuz", "Mail Adresinizi ve Şifrenizi Giriniz");
              }
              c.setBusy(false);
            },
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: TextBasic(text: "veya"),
          ),
          ButtonBorder(
            buttonText: "Kayıt Ol",
            borderColor: UIColor.towerGray,
            onTap: () async {
              Get.to(() => ViewRegister());
            },
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
