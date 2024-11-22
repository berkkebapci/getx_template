// ignore_for_file: depend_on_referenced_packages

import 'package:intl/intl.dart';

// DateTime için extension
extension DateTimeFormatting on DateTime {
  String formatToReadableDateandHour() {
    // İstediğiniz formatı burada belirleyin
    return DateFormat('dd/MM/yyyy - HH:mm').format(this);
  }
  String formatToReadableDate() {
    return DateFormat('dd MMMM yyyy', 'tr_TR').format(this);
  }
}
