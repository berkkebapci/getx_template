// ignore_for_file: depend_on_referenced_packages, avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:getx_template/controllers/controller_base.dart';
import 'package:getx_template/services/check_permission.dart';
import 'package:getx_template/services/location_service.dart';

class ControllerHome extends BaseController {
  @override
  void onInit() async {
    super.onInit();
    setBusy(false);
    init();
  }

  void init() async {
    _notificationService();
    await LocationCheckPermission.checkAndRequestLocationPermission();
    await _getLocation();
    await _getCityAndDistrict(lat.value, long.value);
  }

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  RxInt selectedIndex = 0.obs;
  RxDouble lat = 0.0.obs;
  RxDouble long = 0.0.obs;
  RxString cityName = "".obs;
  RxString districtName = "".obs;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> _getLocation() async {
    LocationService locationService = LocationService();
    Position? position = await locationService.getCurrentLocation();

    if (position != null) {
      print('Konum: ${position.latitude}, ${position.longitude}');
      lat.value = position.latitude;
      long.value = position.longitude;
    }
  }

  Future<void> _getCityAndDistrict(double latitude, double longitude) async {
    final response = await http.get(
      Uri.parse(
        'https://nominatim.openstreetmap.org/reverse?lat=$latitude&lon=$longitude&format=json',
      ),
      headers: {
        "User-Agent": "elele/1.0 (simbertech@gmail.com)",
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      cityName.value = data['address']['province'] ?? data['address']['city'] ?? data['address']['town'] ?? data['address']['village'];
      districtName.value = data['address']['town'] ?? data['address']['suburb'] ?? '';

      print('İl: $cityName, İlçe: $districtName');
    } else {
      throw Exception('Başarısız: ${response.reasonPhrase}');
    }
  }

  void _notificationService() {
    // Token'ı almak için:
    _firebaseMessaging.getToken().then((String? token) {
      print('Firebase Messaging Token: $token');
      // Token'ı sunucuya veya veritabanına kaydedin
    }).catchError((e) {
      print('Error getting token: $e');
    });
    _firebaseMessaging.onTokenRefresh.listen((newToken) {
      print('New Token: $newToken');
      // Yeni token'ı sunucuya veya veritabanına kaydedin
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('OnMessage: ${message.messageId}');
      // Mesajı işleme
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('OnMessageOpenedApp: ${message.messageId}');
      // Mesajı işleme
    });
    _firebaseMessaging.getToken().then((token) {
      print('Firebase Messaging Token: $token');
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('OnMessage: ${message.messageId}');

      // Bildirim içeriğini al
      String title = message.notification?.title ?? 'No Title';
      String body = message.notification?.body ?? 'No Body';

      // Bildirim oluştur ve göster
      _showNotification(title, body);
    });

    _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('OnMessageOpenedApp: ${message.messageId}');
    });

    _firebaseMessaging.getToken().then((token) {
      print('Firebase Messaging Token: $token');
      // Token'ı sunucuya veya veritabanına kaydedin
    }).catchError((e) {
      print('Error getting token: $e');
    });
  }

  Future<void> _showNotification(String title, String body) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      //'your_channel_description',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );
    const NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);

    await _flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
      payload: 'item x',
    );
  }
}
