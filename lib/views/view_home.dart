// ignore_for_file: depend_on_referenced_packages

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_template/controllers/controller_home.dart';
import 'package:getx_template/shared/uicolor.dart';
import 'package:getx_template/views/view_dashboard.dart';
import 'package:getx_template/views/view_discover.dart';
import 'package:getx_template/views/view_messages.dart';
import 'package:getx_template/views/view_profile.dart';

class ViewHome extends StatelessWidget {
  ViewHome({super.key});

  final ControllerHome c = Get.put(ControllerHome());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Buton işlevi buraya eklenebilir
          },
          backgroundColor: UIColor.primary,
          child: const Icon(Icons.add, color: Colors.white),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: AnimatedBottomNavigationBar(
          icons: const [
            Icons.home,
            Icons.search,
            Icons.notifications,
            Icons.person,
          ],
          activeIndex: c.selectedIndex.value,
          activeColor: UIColor.primary,
          inactiveColor: Colors.grey.shade600,
          backgroundColor: Colors.white,
          notchSmoothness: NotchSmoothness.softEdge,
          gapLocation: GapLocation.center,
          onTap: (value) {
            c.selectedIndex.value = value;
          },
        ),
        body: getBody(),
      ),
    );
  }

  Widget getBody() {
    return IndexedStack(
      index: c.selectedIndex.value,
      children: [ViewDashboard(), ViewDiscover(), ViewMessages(), ViewProfile()],
    );
  }
}
