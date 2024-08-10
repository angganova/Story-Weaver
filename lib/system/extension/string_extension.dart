import '../variables/var_dynamic.dart';

extension StringExtension on String? {
  bool get isNull => this == null;
  bool get isNotNull => this != null;
  bool get isNullOrEmpty =>
      this == null ||
      this!.trim().isEmpty ||
      this!.ignoreCaseIgnoreSpace('null');
  bool get isNotNullOrEmpty => !isNullOrEmpty;

  bool get isNumber {
    try {
      num.parse(this!);
      return true;
    } catch (_) {
      return false;
    }
  }

  bool get isBool =>
      ignoreCase('true') ||
      ignoreCase('false') ||
      ignoreCase('1') ||
      ignoreCase('0') ||
      ignoreCase('ok');

  bool get toBool {
    if (isBool) {
      return ignoreCase('true') || ignoreCase('1') || ignoreCase('ok');
    } else if (ignoreCase('200')) {
      return true;
    } else {
      return false;
    }
  }

  bool? get toBoolNull {
    if (isBool) {
      return ignoreCase('true') || ignoreCase('1') || ignoreCase('ok');
    } else if (ignoreCase('200')) {
      return true;
    } else {
      return null;
    }
  }

  int get toInt {
    if (isNumber) {
      return int.tryParse(this!) ?? 0;
    } else {
      return 0;
    }
  }

  double get toDouble {
    if (isNumber) {
      return double.tryParse(this!) ?? 0;
    } else {
      return 0;
    }
  }

  num get toNum {
    if (isNumber) {
      return num.tryParse(this!) ?? 0;
    } else {
      return 0;
    }
  }

  String get phoneNumberStart0 {
    if (this == null) {
      return '';
    } else if (this!.startsWith('+62')) {
      return this!.replaceFirst('+62', '0');
    } else if (this!.startsWith('62')) {
      return this!.replaceFirst('62', '0');
    } else {
      return this ?? '';
    }
  }

  String get phoneNumberStart62 {
    if (this == null) {
      return '';
    } else if (this!.startsWith('+62')) {
      return this!.replaceFirst('+62', '62');
    } else if (this!.startsWith('0')) {
      return this!.replaceFirst('0', '62');
    } else {
      return this ?? '';
    }
  }

  String get phoneNumberStartPlus62 {
    if (this == null) {
      return '';
    } else if (this!.startsWith('+62')) {
      return this!;
    } else if (this!.startsWith('0')) {
      return this!.replaceFirst('0', '+62');
    } else if (this!.startsWith('62')) {
      return this!.replaceFirst('62', '+62');
    } else {
      return this ?? '';
    }
  }

  bool containIgnoreCase(String s2) {
    return this!.toLowerCase().contains(s2.toLowerCase()) &&
        this!.toUpperCase().contains(s2.toUpperCase());
  }

  bool ignoreCase(String? s2) {
    return this?.toLowerCase() == (s2 ?? '').toLowerCase() &&
        this?.toUpperCase() == (s2 ?? '').toUpperCase();
  }

  bool ignoreCaseIgnoreSpace(String? s2) {
    s2 ??= '';
    return removeSpace.toLowerCase() == s2.removeSpace.toLowerCase() &&
        removeSpace.toUpperCase() == s2.removeSpace.toUpperCase();
  }

  String get removeSpace => toString().replaceAll(' ', '');

  bool get isDate {
    try {
      DateTime.parse(this!);
      return true;
    } catch (e) {
      return false;
    }
  }

  DateTime? get toDate {
    try {
      return DateTime.parse(this!).toLocal();
    } catch (e) {
      return null;
    }
  }

  String get splitCamelCase {
    try {
      final RegExp camelCasePattern = RegExp(r'(?<=[a-z])(?=[A-Z])');
      final List<String> words = this!.split(camelCasePattern);
      return words.join(' ');
    } catch (_) {
      return this ?? '';
    }
  }

  String get capsWord => isNotNullOrEmpty
      ? '${this![0].toUpperCase()}${this!.substring(1).toLowerCase()}'
      : '';

  String get capsWords {
    try {
      return this!
          .toLowerCase()
          .split(' ')
          .map((String word) =>
              word[0].toUpperCase() + word.substring(1).toLowerCase())
          .join(' ');
    } catch (_) {
      return this ?? '';
    }
  }

  String get capsSentence => isNotNullOrEmpty
      ? '${this![0].toUpperCase()}${this!.substring(1).toLowerCase()}'
      : '';

  String get capsSentences {
    try {
      return this!
          .split('. ')
          .map((String sentence) =>
              sentence[0].toUpperCase() + sentence.substring(1))
          .join('. ');
    } catch (_) {
      return this!;
    }
  }

  bool get isEmail => RegExp(emailPattern.toString()).hasMatch(this!);

  static const String diacritics =
      'ÀÁÂÃÄÅàáâãäåÒÓÔÕÕÖØòóôõöøÈÉÊËèéêëðÇçÐÌÍÎÏìíîïÙÚÛÜùúûüÑñŠšŸÿýŽž';
  static const String nonDiacritics =
      'AAAAAAaaaaaaOOOOOOOooooooEEEEeeeeeCcDIIIIiiiiUUUUuuuuNnSsYyyZz';

  String get withoutDiacriticalMarks => this!.splitMapJoin('',
      onNonMatch: (String char) => char.isNotEmpty && diacritics.contains(char)
          ? nonDiacritics[diacritics.indexOf(char)]
          : char);

  int get rawInt {
    if (isNullOrEmpty) {
      return 0;
    } else {
      return this!
          .replaceAll('.', '')
          .replaceAll('Rp', '')
          .trim()
          .replaceAll(',', '.')
          .toDouble
          .floor();
    }
  }

  double get rawDouble {
    if (isNullOrEmpty) {
      return 0;
    } else {
      return this!
          .replaceAll('.', '')
          .replaceAll('Rp', '')
          .replaceAll('% p.a', '')
          .trim()
          .replaceAll(',', '.')
          .toDouble;
    }
  }

  String get rawProjectName {
    if (isNullOrEmpty) {
      return '';
    } else {
      return this!
          .toLowerCase()
          .replaceAll('project financing - ', '')
          .replaceAll('invoice financing - ', '')
          .trim();
    }
  }
}
