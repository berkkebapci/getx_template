// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_template/controllers/controller_user_auth/controller_register.dart';
import 'package:getx_template/shared/uicolor.dart';
import 'package:getx_template/shared/uipath.dart';
import 'package:getx_template/widgets/widget_activity_indicator.dart';
import 'package:getx_template/widgets/widget_alert_dialog.dart';
import 'package:getx_template/widgets/widget_buttons.dart';
import 'package:getx_template/widgets/widget_text.dart';
import 'package:getx_template/widgets/widget_textfield.dart';

class ViewRegister extends StatelessWidget {
  ViewRegister({super.key});
  final ControllerRegister c = Get.put(ControllerRegister());

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: UIColor.white, body: getBody(context));
  }

  Widget getBody(BuildContext context) {
    return Obx(
      () => c.busy == true
          ? const WidgetActivityIndicator()
          : SingleChildScrollView(
            physics: const ScrollPhysics(),
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [getImage(), getRegister()],
            ),
          ),
    );
  }

  Widget getImage() {
    return Container(
      padding: const EdgeInsets.only(top: 60),
      height: Get.height,
      decoration: BoxDecoration(
        color: UIColor.primary,
      ),
      child: Align(
        alignment: Alignment.topCenter,
        child: Image.asset(
          UIPath.logo,
          height: 100,
        ),
      ),
    );
  }

  Widget getRegister() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
            const SizedBox(
              height: 32,
            ),
            const Align(
                alignment: Alignment.centerLeft,
                child: TextBasic(
                  text: "Kayıt Ol",
                  isItalic: true,
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                )),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: BasicTextField(
                hint: "Ad",
                controller: c.nameController,
                keyboardType: TextInputType.name,
              ),
            ),
            BasicTextField(
              hint: "Soyad",
              controller: c.surnameController,
              keyboardType: TextInputType.name,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: BasicTextField(
                hint: "Mail",
                controller: c.emailController,
                textCapitalization: TextCapitalization.none,
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            BasicTextField(
              hint: "Telefon",
              controller: c.phoneController,
              inputFormatters: [c.maskFormatter],
              focusNode: c.focusNode,
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () {
                _showCitySelection();
              },
              child: BasicTextField(
                hint: "İl",
                controller: c.cityController,
                enabled: false,
              ),
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () {
                c.selectedCity.value != "" ? _showDistrictSelection() : null;
              },
              child: BasicTextField(
                hint: "İlçe",
                controller: c.districtController,
                enabled: false,
              ),
            ),
            const SizedBox(height: 16),
            BasicTextField(
              hint: "Şifre",
              controller: c.passwordController,
              keyboardType: TextInputType.visiblePassword,
              textCapitalization: TextCapitalization.none,
            ),
            const SizedBox(height: 20),
            ButtonBasic(
              buttonText: "Kayıt Ol",
              bgGradientColor: UIGradient.primaryGradient,
              onTap: () async {
                if (c.emailController.text.isNotEmpty &&
                    c.passwordController.text.isNotEmpty &&
                    c.nameController.text.isNotEmpty &&
                    c.surnameController.text.isNotEmpty &&
                    c.selectedCity.value != "" &&
                    c.selectedDistrict.value != "") {
                  await c.registerWithEmailPassword(c.emailController.text, c.passwordController.text);
                } else {
                  showAlertDialogFailed("Lütfen Gerekli Alanları Doldurunuz", "Boş Bırakılan Alanları Doldurunuz.");
                }
              },
            ),
            const SizedBox(height: 40)
          ],
        ),
      ),
    );
  }

  void _showCitySelection() {
    Get.bottomSheet(
      SizedBox(
        height: Get.height * .7,
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: TextBasic(
                text: 'İl Seçin',
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: c.cities.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: TextBasic(text: c.cities[index]['name']),
                    onTap: () {
                      c.selectedCity.value = c.cities[index]['name'];
                      c.cityController.text = c.selectedCity.value;
                      c.districtController.clear();
                      c.filteredDistricts = [];
                      c.onCitySelected(c.cities[index]['id']);
                      FocusScope.of(context).unfocus();
                      Navigator.pop(context); // Modalı kapat
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      backgroundColor: UIColor.white, isScrollControlled: true, // Scroll kontrolünü aç
    );
  }

  void _showDistrictSelection() {
    Get.bottomSheet(
        SizedBox(
          height: 600,
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: TextBasic(
                  text: 'İlçe Seçin',
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: c.filteredDistricts.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: TextBasic(text: c.filteredDistricts[index]['name']),
                      onTap: () {
                        c.selectedDistrict.value = c.filteredDistricts[index]['name'];
                        c.districtController.text = c.selectedDistrict.value;
                        c.districtId.value = c.filteredDistricts[index]['id'];
                        FocusScope.of(context).unfocus();
                        Navigator.pop(context); // Modalı kapat
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        backgroundColor: UIColor.white);
  }
}
