// ignore_for_file: depend_on_referenced_packages, avoid_print, unused_import

import 'dart:io'; /* 
import 'package:elele/shared/theme.dart';
import 'package:elele/shared/uicolor.dart';
import 'package:elele/views/view_home.dart';
import 'package:elele/views/view_onboarding.dart';
import 'package:elele/views/view_user_auth/view_login.dart'; */
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
//import 'package:getx_template/firebase_options.dart';
import 'package:getx_template/views/view_home.dart';
import 'package:upgrader/upgrader.dart';
//import 'firebase_options.dart';
import 'package:get/get.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_storage/get_storage.dart';
//import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
/* 
   try {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  } catch (e) {
    print("Firebase zaten başlatıldı: $e");
  }  */

  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  const DarwinInitializationSettings initializationSettingsIos = DarwinInitializationSettings();
  const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
  const InitializationSettings initializationSettings = InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIos);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await GetStorage.init();
  //MobileAds.instance.initialize();
  Upgrader().initialize();
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  //final ThemeController themeController = Get.put(ThemeController());

  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'elele',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('tr', ''),
        Locale('en', ''),
      ],
      //theme: themeController.lightTheme,
      //darkTheme: themeController.darkTheme,
      home: ViewHome(),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    final client = super.createHttpClient(context);
    client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    return client;
  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message: ${message.messageId}');
  // Eğer gerekliyse burada bildirim gösterimi yapabilirsiniz
}

/* Widget getCheckSeenOnboarding() {
  final box = GetStorage();

  if (box.read('isSeenOnboarding') != null) {
    if (box.read('isSeenOnboarding') == false) {
      return ViewOnBoarding();
    } else {
      if (box.read('isSeenOnboarding') == true) {
        return ViewLogin();
      }
    }
  }
  return ViewOnBoarding();
} */
