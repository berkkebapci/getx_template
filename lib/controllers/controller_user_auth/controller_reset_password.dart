// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:getx_template/controllers/controller_base.dart';
import 'package:getx_template/views/view_user_auth/view_login.dart';
import 'package:getx_template/widgets/widget_alert_dialog.dart';

class ControllerResetPassword extends BaseController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController emailController = TextEditingController();

  Future<void> resetPassword() async {
    setBusy(true);
    if (emailController.text.isNotEmpty) {
      try {
        await _auth.sendPasswordResetEmail(email: emailController.text);
        showAlertDialogSuccessWithButton(
            'İşlem Başarıyla Gerçekleştirildi', 'Şifre sıfırlama bağlantısı e-posta adresinize gönderildi.', ViewLogin(), "Giriş Yap");
      } on FirebaseAuthException catch (e) {
        if (e.message == "The email address is badly formatted.") {
          showAlertDialogFailed('Bir Sorun Meydana Geldi ', 'E-posta Adresinizi Kontrol Ediniz');
        } else {
          showAlertDialogFailed('Bir Sorun Meydana Geldi ', '${e.message}');
        }
      } catch (e) {
        showAlertDialogFailed('Bir Sorun Meydana Geldi', 'Lütfen Daha Sonra Tekrar Deneyiniz');
      }
    } else {
      showAlertDialogFailed("Bir Sorun Meydana Geldi", "E-posta Adresinizi Kontrol Ediniz");
    }
    setBusy(false);
  }
}
