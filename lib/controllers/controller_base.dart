// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class BaseController extends GetxController {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  var scaffold = GlobalKey<ScaffoldState>();
  final RxBool _busy = false.obs;
  bool get busy => _busy.value;

  void setBusy(bool val) {
    _busy.value = val;
  }
}
