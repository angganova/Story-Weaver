import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'num_extension.dart';

// dependencies:
// intl: ^0.17.0

extension DateTimeExtension on DateTime? {
  bool get isNull => this == null;
  bool get isNotNull => this != null;
  bool isEqual(DateTime i) => this == i;
  bool isSameDay(DateTime date) {
    try {
      return this!.day.isEqual(date.day) &&
          this!.month.isEqual(date.month) &&
          this!.year.isEqual(date.year);
    } catch (_) {
      return true;
    }
  }

  String formatDate(String format) {
    try {
      final DateFormat formatter = DateFormat(format);
      return formatter.format(this!);
    } catch (_) {
      return '';
    }
  }
}

extension TimeOfDayExtension on TimeOfDay {
  String get getTime {
    try {
      final String timeString = toString();

      return timeString.substring(
          timeString.indexOf('(') + 1, timeString.lastIndexOf(')'));
    } catch (_) {
      return '';
    }
  }
}
