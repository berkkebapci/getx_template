// ignore_for_file: depend_on_referenced_packages, avoid_print

import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get_storage/get_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_template/controllers/controller_base.dart';
import 'package:getx_template/services/version_checker.dart';
import 'package:getx_template/views/view_home.dart';
import 'package:getx_template/widgets/widget_alert_dialog.dart';

class ControllerLogin extends BaseController {
  @override
  onInit() {
    super.onInit();
    init();
  }

  Future<void> init() async {
    await getSavedUserInfo();
    await fetchLatestVersion();
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  RxBool isVisible = true.obs;
  RxBool isRemember = true.obs;
  RxString latestVersion = '1.0.0'.obs;
  RxBool forceUpdate = true.obs;
  RxString token = "".obs;

  final box = GetStorage();

  Future<void> fetchLatestVersion() async {
    try {
      latestVersion.value = await VersionChecker.fetchLatestVersionFromRemoteConfig();
      forceUpdate.value = await VersionChecker.fetchForceUpdateFromRemoteConfig();
      print("Latest version: ${latestVersion.value}");
      print("Force update: ${forceUpdate.value}");
    } catch (e) {
      print("Error fetching latest version: $e");
      // Varsayılan değeri koruma veya hata işleme
    }
  }

  Future<User?> signInWithEmailPassword(String email, String password) async {
    setBusy(true);
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      if (result.user != null) {
        saveUserInfo();
        //await saveUserFcmToken(result.user!.uid);
        Get.delete<ControllerLogin>();
        Get.offAll(() => ViewHome());
      } else {
        showAlertDialogFailed("Bir Sorunla Karşılaşıldı", "Lütfen Mail Adresinizi ve Şifrenizi Kontrol Ediniz");
      }
      log(result.user.toString());
    } catch (e) {
      if (e is FirebaseException) {
        if (e.message == "The email address is badly formatted.") {
          showAlertDialogFailed("Bir Sorunla Karşılaşıldı", "Lütfen Mail Adresi Formatınızı Kontrol Ediniz");
        } else if (e.message == "The supplied auth credential is incorrect, malformed or has expired.") {
          showAlertDialogFailed("Bir Sorunla Karşılaşıldı", "Lütfen Mail Adresinizi ve Şifrenizi Kontrol Ediniz");
        } else if (e.message ==
            "Access to this account has been temporarily disabled due to many failed login attempts. You can immediately restore it by resetting your password or you can try again later.") {
          showAlertDialogFailed("Bir Sorunla Karşılaşıldı",
              "Birçok Kez Başarısız Giriş Denemesi Yapıldığından Hesabınız Geçici Olarak Devre Dışı Bırakılmıştır. Şifrenizi Sıfırlayabilirsiniz veya Daha Sonra Tekrar Deneyiniz.");
        } else {
          showAlertDialogFailed("Bir Sorunla Karşılaşıldı", "Lütfen Daha Sonra Tekrar Deneyiniz.");
        }
      }
      log(e.toString());
    }
    setBusy(false);
    return null;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  void setVisible(bool value) {
    isVisible.value = value;
  }

  void setRemember(bool value) {
    isRemember.value = !isRemember.value;
  }

  void saveUserInfo() {
    box.write('userMail', emailController.text);
    box.write('password', passwordController.text);
  }

  Future<void> getSavedUserInfo() async {
    setBusy(true);
    if (await box.read('userMail') != null) {
      emailController.text = await box.read('userMail');
      passwordController.text = await box.read('password');
    }
    setBusy(false);
  }

  Future<void> saveUserFcmToken(String userId) async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    // Token alınıyor
    token.value = await messaging.getToken() ?? "";

    // Token'ı Firestore'da kullanıcı bilgilerine ekleme
    await FirebaseFirestore.instance.collection('users').doc(userId).update({'fcmToken': token});
    }
}
