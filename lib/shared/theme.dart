import 'package:flutter/material.dart';
import 'package:get/get.dart';

//TODO: DAHA SONRA GELİŞTİRİLECEKTİR

class ThemeController extends GetxController {
  // Varsayılan olarak light theme
  RxBool isDarkTheme = false.obs;

  ThemeData get currentTheme => isDarkTheme.value ? ThemeData.dark() : ThemeData.light();

  void toggleTheme() {
    isDarkTheme.value = !isDarkTheme.value;
    Get.changeTheme(currentTheme);
  }
/* 
  ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.blue,
    brightness: Brightness.light,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,
    ),
  );

  ThemeData darkTheme = ThemeData(
    primarySwatch: Colors.deepPurple,
    brightness: Brightness.dark,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
    ),
  ); */
}
