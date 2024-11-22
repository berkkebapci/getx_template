// ignore_for_file: depend_on_referenced_packages, must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_template/controllers/controller_matching.dart';
import 'package:getx_template/shared/uicolor.dart';

class ViewMatching extends StatelessWidget {
  ViewMatching({super.key});

  ControllerMatching controllerMatching = Get.put(ControllerMatching());
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: UIGradient.primaryGradient),
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.transparent,
        body: getBody(),
      ),
    );
  }

  Widget getBody() {
    return SafeArea(
      child: RefreshIndicator(
          onRefresh: () async {
            await controllerMatching.init();
          },
          child: Container()),
    );
  }
}
