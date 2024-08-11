import 'dart:math';

class DataUtils {
  static int getCurrentUnixTimestamp() {
    return DateTime.now().millisecondsSinceEpoch ~/ 1000;
  }

  static int generateRandomNumber(int min, int max) {
    final random = Random();
    return min + random.nextInt(max - min + 1);
  }
}
