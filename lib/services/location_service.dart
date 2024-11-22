import 'dart:developer';

import 'package:geolocator/geolocator.dart';

class LocationService {
  Future<Position?> getCurrentLocation() async {
    try {
      bool serviceEnabled;
      LocationPermission permission;

      // Konum servisi aktif mi kontrol et
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        log('Konum servisi etkin değil.');
        return null; // Kullanıcıya hizmeti etkinleştirmesini söyleyin
      }

      // İzin durumunu kontrol et
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          log('Konum izni reddedildi.');
          return null; // İzin verilmezse işlem yapılmaz
        }
      }

      if (permission == LocationPermission.deniedForever) {
        log('Konum izni kalıcı olarak reddedildi.');
        return null; // Kalıcı olarak reddedildiyse işlem yapılmaz
      }

      // Konum bilgisini al
      return await Geolocator.getCurrentPosition();
    } catch (e) {
      log('Konum alınırken bir hata oluştu: $e');
      return null;
    }
  }
}
