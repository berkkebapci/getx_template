// ignore_for_file: deprecated_member_use

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationCheckPermission {
  static RxDouble lat = 0.0.obs;
  static RxDouble long = 0.0.obs;

  static Future<void> checkAndRequestLocationPermission() async {
    var status = await Permission.location.status;
    if (status.isDenied) {
      // İzin daha önce reddedildiyse tekrar sor
      if (await Permission.location.request().isGranted) {
        Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
        lat.value = position.latitude;
        long.value = position.longitude;
      }
    } else if (status.isGranted) {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      lat.value = position.latitude;
      long.value = position.longitude;
    } else if (status.isPermanentlyDenied) {
      // Kullanıcı ayarlardan izin vermesi gerekiyor
      openAppSettings();
    }
  }
}
