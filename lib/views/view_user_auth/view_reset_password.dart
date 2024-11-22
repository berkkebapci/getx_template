// ignore_for_file: depend_on_referenced_packages, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_template/controllers/controller_user_auth/controller_reset_password.dart';
import 'package:getx_template/widgets/widget_activity_indicator.dart';
import 'package:getx_template/widgets/widget_buttons.dart';
import 'package:getx_template/widgets/widget_text.dart';
import 'package:getx_template/widgets/widget_textfield.dart';

class ViewResetPassword extends StatefulWidget {
  const ViewResetPassword({super.key});

  @override
  _ViewResetPasswordState createState() => _ViewResetPasswordState();
}

class _ViewResetPasswordState extends State<ViewResetPassword> {
  ControllerResetPassword c = Get.put(ControllerResetPassword());
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: getAppBar(), body: getBody());
  }

  AppBar getAppBar() {
    return AppBar(
      title: const TextBasic(text: 'Şifre Sıfırlama'),
    );
  }

  Widget getBody() {
    return Obx(
      () => c.busy
          ? const WidgetActivityIndicator()
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  BasicTextField(
                    controller: c.emailController,
                    hint: "E-posta Adresi",
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: ButtonBasic(
                      buttonText: "Şifremi Sıfırla",
                      onTap: () async {
                        await c.resetPassword();
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
