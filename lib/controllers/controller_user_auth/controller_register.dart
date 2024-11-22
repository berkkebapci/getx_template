// ignore_for_file: depend_on_referenced_packages

import 'dart:developer';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:getx_template/controllers/controller_base.dart';
import 'package:getx_template/services/get_city_and_district.dart';
import 'package:getx_template/views/view_user_auth/view_login.dart';
import 'package:getx_template/widgets/widget_alert_dialog.dart';

class ControllerRegister extends BaseController {
  @override
  void onInit() async {
    super.onInit();
    setBusy(false);
    init();
  }

  Future<void> init() async {
    // FocusNode'un dinleyicisi
    focusNode.addListener(() {
      if (focusNode.hasFocus && phoneController.text.isEmpty) {
        phoneController.text = '(05';
        // İmleci metnin sonuna koy
        phoneController.selection = TextSelection.fromPosition(
          TextPosition(offset: phoneController.text.length),
        );
      }
    });
    List<dynamic> loadedCities = await getCityAndDistrict.loadCities();
    cities = loadedCities;
  }

  GetCityAndDistrict getCityAndDistrict = GetCityAndDistrict();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController districtController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  FocusNode focusNode = FocusNode();
  List<dynamic> cities = [];
  List<dynamic> filteredDistricts = [];
  RxString selectedCity = "".obs;
  RxString selectedDistrict = "".obs;
  RxString cityId = "".obs;
  RxString districtId = "".obs;
  var maskFormatter = MaskTextInputFormatter(mask: '(05##) ### ## ##', filter: {"#": RegExp(r'[0-9]')}, type: MaskAutoCompletionType.lazy);

  List<dynamic> filterDistrictsByCityId(List<dynamic> districts, String cityId) {
    return districts.where((district) => district['il_id'] == cityId).toList();
  }

  void onCitySelected(String selectedCityId) async {
    List<dynamic> districts = await getCityAndDistrict.loadDistricts();
    cityId.value = selectedCityId;
    filteredDistricts = filterDistrictsByCityId(districts, selectedCityId);
  }

  Future<User?> registerWithEmailPassword(String email, String password) async {
    setBusy(true);
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(email: emailController.text, password: passwordController.text);
      // Kayıt başarılı
      var user = userCredential.user;
      await _firestore.collection('users').doc(user?.uid).set({
        'name': nameController.text,
        'surname': surnameController.text,
        'email': emailController.text,
        'phoneNumber': phoneController.text,
        'uid': user?.uid,
        'cityId': cityId.value,
        'city': selectedCity.value,
        'districtId': districtId.value,
        'district': selectedDistrict.value,
        'profileImageUrl': '',
        'isHiddenPhoneNumber': false,
        'isPhoneVerified': false
      });
      showAlertDialogSuccessWithButton(
        "Kayıt İşlemi Başarılı",
        "Lütfen Giriş Yapınız",
        ViewLogin(),
        "Giriş Yap",
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        log('The password provided is too weak.');
        showAlertDialogFailed("Bir Sorun Meydana Geldi", "Daha Güçlü Bir Şifre Kullanınız");
      } else if (e.code == 'email-already-in-use') {
        log('The account already exists for that email.');
        showAlertDialogFailed("Bir Sorun Meydana Geldi", "Mail Adresi Daha Önce Kullanılmış. Farklı Bir Mail Adresi Deneyiniz");
      } else if (e.code == 'invalid-email') {
        log('The email address is badly formatted.');
      } else {
        log('Error: ${e.message}');
        showAlertDialogFailed("Bir Sorun Meydana Geldi", "Lütfen Daha Sonra Tekrar Deneyiniz");
      }
    } catch (e) {
      log(e.toString());
      showAlertDialogFailed("Bir Sorun Meydana Geldi", "Lütfen Daha Sonra Tekrar Deneyiniz");
    }
    setBusy(false);
    return null;
  }
}
