// ignore_for_file: depend_on_referenced_packages, must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_template/controllers/controller_dashboard.dart';
import 'package:getx_template/shared/uicolor.dart';
import 'package:getx_template/widgets/widget_text.dart';

class ViewDashboard extends StatelessWidget {
  ViewDashboard({super.key});

  ControllerDashboard controllerDashboard = Get.put(ControllerDashboard());
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.grey.shade50,
      appBar: getAppBar(),
      body: getBody(),
      drawer: getDrawer(),
    );
  }

  AppBar getAppBar() {
    return AppBar(
      backgroundColor: UIColor.white,
      title: const TextBasic(
        text: "Anasayfa",
        fontWeight: FontWeight.w500,
      ),
      actions: const [],
      leading: GestureDetector(
          onTap: () {
            _scaffoldKey.currentState?.openDrawer(); // Drawer'ı açma
          },
          child: const Icon(Icons.menu)),
    );
  }

  Widget getBody() {
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () async {
          await controllerDashboard.init();
        },
        child:  ListView(
            children: const [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 12),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: TextBasic(
                      text: "Kategoriler",
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    )),
              ),
            ],
          ),
        
      ),
    );
  }

  Widget getDrawer() {
    return Drawer(
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          children: [
            const SizedBox(
              height: 60,
            ),
            GestureDetector(
              onTap: () {
                //Get.to(() => ViewMyPosts());
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Icon(
                      Icons.post_add_outlined,
                      size: 20,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    TextBasic(
                      text: "İlanlarım",
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                    Spacer(),
                    Icon(Icons.keyboard_arrow_right)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
