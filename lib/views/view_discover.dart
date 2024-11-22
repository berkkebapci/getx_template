// ignore_for_file: depend_on_referenced_packages, must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_template/controllers/controller_discover.dart';
import 'package:getx_template/shared/uicolor.dart';
import 'package:getx_template/widgets/widget_text.dart';

class ViewDiscover extends StatelessWidget {
  ViewDiscover({super.key});

  ControllerDiscover controllerDiscover = Get.put(ControllerDiscover());
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.grey.shade50,
      appBar: getAppBar(),
      body: getBody(),
    );
  }

  AppBar getAppBar() {
    return AppBar(
      backgroundColor: UIColor.white,
      title: const TextBasic(
        text: "Keşfet",
        fontWeight: FontWeight.w500,
      ),
      actions: const [],
      leading: GestureDetector(
          onTap: () {
            _scaffoldKey.currentState?.openDrawer();
          },
          child: const Icon(Icons.menu)),
    );
  }

  Widget getBody() {
    return SafeArea(
      child: RefreshIndicator(
          onRefresh: () async {
            await controllerDiscover.init();
          },
          child: Container()),
    );
  }
}
