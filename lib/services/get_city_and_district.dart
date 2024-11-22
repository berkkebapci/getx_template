import 'dart:convert';
import 'package:flutter/services.dart';

class GetCityAndDistrict {
  Future<List<dynamic>> loadCities() async {
    String jsonString = await rootBundle.loadString('assets/data/cities.json');
    final Map<String, dynamic> jsonResponse = json.decode(jsonString);
    return jsonResponse['cities'];
  }

  Future<List<dynamic>> loadDistricts() async {
    final jsonString = await rootBundle.loadString('assets/data/districts.json');
    final List<dynamic> districts = json.decode(jsonString)['district'];
    return districts;
  }
}
