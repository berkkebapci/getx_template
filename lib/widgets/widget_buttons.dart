// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:getx_template/shared/uicolor.dart';
import 'package:getx_template/shared/uipath.dart';
import 'package:getx_template/widgets/widget_text.dart';

class ButtonBasic extends StatelessWidget {
  final String? buttonText;
  final Color? bgColor;
  final LinearGradient? bgGradientColor;
  final Color? textColor;
  final Function()? onTap;
  final int? flex;
  final double? radius;
  final double? height;
  final double? padding;
  final FontWeight? fontWeight;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final double elevation;
  final double? fontSize;

  const ButtonBasic({
    super.key,
    this.buttonText,
    this.bgColor,
    this.textColor,
    this.onTap,
    this.flex,
    this.radius,
    this.height,
    this.bgGradientColor,
    this.fontWeight,
    this.padding,
    this.prefixIcon,
    this.suffixIcon,
    this.fontSize,
    this.elevation = 0,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height ?? 50,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: bgGradientColor,
          color: bgColor ?? UIColor.primary,
          borderRadius: BorderRadius.all(Radius.circular(radius ?? 6)),
        ),
        padding: EdgeInsets.symmetric(horizontal: padding ?? 0),
        child: Row(
          mainAxisAlignment: (suffixIcon != null) ? MainAxisAlignment.spaceBetween : MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (suffixIcon != null)
              Container(
                padding: const EdgeInsets.only(left: 32),
              ),
            if (prefixIcon != null) prefixIcon!,
            Flexible(
              child: TextBasic(
                text: buttonText ?? "",
                color: textColor ?? UIColor.white,
                fontSize: fontSize ?? 16,
                fontWeight: fontWeight ?? FontWeight.w600,
                textAlign: TextAlign.center,
                maxLines: 1,
              ),
            ),
            if (suffixIcon != null)
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: suffixIcon!,
              ),
          ],
        ),
      ),
    );
  }
}

class ButtonBorder extends StatelessWidget {
  final String? buttonText;
  final Color borderColor;
  final Color? textColor;
  final Color? buttonColor;
  final Function()? onTap;
  final int? flex;
  final double? radius;
  final double? height;
  final double? padding;
  final Widget? prefixIcon;
  final double elevation;
  final double? fontSize;
  final String? fontFamily;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;

  // ignore: use_key_in_widget_constructors
  const ButtonBorder(
      {this.buttonText,
      required this.borderColor,
      this.textColor,
      this.buttonColor,
      this.onTap,
      this.flex,
      this.radius,
      this.height,
      this.padding,
      this.prefixIcon,
      this.fontSize,
      this.fontFamily,
      this.fontWeight,
      this.textAlign,
      this.elevation = 0});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height ?? 50,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: buttonColor ?? UIColor.transparent,
          border: Border.all(color: borderColor, width: 1),
          borderRadius: const BorderRadius.all(
            Radius.circular(6),
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: padding ?? 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (prefixIcon != null) prefixIcon!,
            Flexible(
              child: TextBasic(
                text: buttonText ?? "",
                color: textColor,
                fontSize: fontSize ?? 16,
                fontFamily: fontFamily,
                fontWeight: fontWeight ?? FontWeight.w700,
                textAlign: textAlign ?? TextAlign.center,
                maxLines: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BasicBackButton extends StatelessWidget {
  const BasicBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.back();
      },
      child: SvgPicture.asset(
        UIPath.leftArrow,
        fit: BoxFit.scaleDown,
      ),
    );
  }
}

