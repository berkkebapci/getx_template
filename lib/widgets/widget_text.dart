// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextBasic extends StatelessWidget {
  final String text;
  final Color? color;
  final String? fontFamily;
  final double? fontSize;
  final double? lineHeight;
  final TextAlign? textAlign;
  final int? maxLines;
  final FontWeight? fontWeight;
  final bool isItalic;
  final bool lineThrough;
  final bool isUnderline;

  const TextBasic({
    super.key,
    required this.text,
    this.color,
    this.fontFamily,
    this.fontSize,
    this.lineHeight,
    this.isItalic = false,
    this.textAlign,
    this.maxLines,
    this.fontWeight,
    this.lineThrough = false,
    this.isUnderline = false,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      textAlign: textAlign,
      maxLines: maxLines ?? 999,
      style: GoogleFonts.firaSans(
          fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color,
          decoration: isUnderline == true ? TextDecoration.underline : TextDecoration.none,
          height: lineHeight),
    );
  }
}
