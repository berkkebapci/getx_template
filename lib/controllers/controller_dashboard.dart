// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:getx_template/controllers/controller_base.dart';

class ControllerDashboard extends BaseController {
  @override
  void onInit() {
    super.onInit();
    init();
  }

  Future<void> init() async {
  }

  RxList<Map<String, dynamic>> recentPosts = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> favPosts = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> categoriesList = <Map<String, dynamic>>[].obs;
  User? user = FirebaseAuth.instance.currentUser;


}
