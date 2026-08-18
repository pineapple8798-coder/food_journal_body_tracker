import 'dart:math';

class DbUtils {
  static final Random _random = Random.secure();

  static String newId() {
    final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    final suffix = _random.nextInt(0x7fffffff).toRadixString(16).padLeft(8, '0');
    return '${timestamp}_$suffix';
  }

  static String formatDateKey(DateTime date) {
    final y = date.year.toString().padLeft(4, '0');
    final m = date.month.toString().padLeft(2, '0');
    final d = date.day.toString().padLeft(2, '0');
    return '$y-$m-$d';
  }
}
