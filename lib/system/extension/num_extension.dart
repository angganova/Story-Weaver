import 'package:intl/intl.dart';

// dependencies:
// intl: ^0.17.0

extension NumExtension on num {
  bool isEqual(num i) => this == i;
  bool isMoreThan(num i) => this > i;
  bool isLessThan(num i) => this < i;
  bool isMoreOrEqualTo(num i) => this >= i;
  bool isLessOrEqualTo(num i) => this <= i;
  bool isBetween(num i, num j) => this >= i && this <= j;

  bool get isZero => this == 0;
  bool get isLessThanZero => this < 0;
  bool get isMoreThanZero => this > 0;
  bool get isInteger => this is int || this == roundToDouble();
  bool get isWhole => this % 1 == 0;
  num get wholeDisplay => isWhole ? toInt() : toDouble();

  DateTime get toDate => DateTime.fromMillisecondsSinceEpoch(toInt() * 1000);

  String formatCurrency({
    String currency = 'Rp',
    int decimalPlace = 0,
    String separator = '.',
    bool withSpacer = false,
  }) {
    if (abs().isLessThan(100)) {
      return '$currency${withSpacer ? ' ' : ''}${formatDecimal(decimalPlace)}';
    }

    String formatPattern = '#,###';

    if (decimalPlace.isMoreThanZero) {
      formatPattern += '.';
      List<String>.generate(decimalPlace, (int index) => formatPattern += '0');
    }

    final NumberFormat formatCurrency = NumberFormat(formatPattern);
    final String result =
        '$currency${withSpacer ? ' ' : ''}${formatCurrency.format(this)}';

    if (separator == '.') {
      final List<String> stringList = result.split('.');
      stringList[0] = stringList[0].replaceAll(',', '.');
      if (stringList.length.isMoreThan(1)) {
        stringList[1].replaceAll('.', ',');
      }
      return stringList.join(',');
    }
    return result;
  }

  String formatThousand({String separator = ','}) {
    if (isLessThan(1000)) {
      return '${floor()}';
    }

    final NumberFormat formatCurrency = NumberFormat('#$separator###');
    return formatCurrency.format(floor()).replaceAll(',', '.');
  }

  String formatThousandWithK({bool showZero = false}) {
    if (isZero && showZero) {
      return toString();
    } else if (isZero || isLessThanZero) {
      return '';
    } else if ((this % 1000).isZero) {
      final int newValue = (this / 1000).floor();
      return '${newValue.toStringAsFixed(0)}K';
    } else {
      return toStringAsFixed(0);
    }
  }

  String formatDecimal(int n) => toStringAsFixed(n);

  double toFixed(int fraction) => double.parse(toStringAsFixed(fraction));

  String getDecimalParts({String separator = '.', String defaultValue = '00'}) {
    final String decimalParts = toStringAsFixed(2).split(separator)[1];
    return '.$decimalParts';
  }
}
