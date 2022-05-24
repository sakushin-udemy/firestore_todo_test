import 'package:intl/intl.dart';

class Utilities {
  Utilities._();

  static late final DateFormat _dfyyyyMMdd = DateFormat('yyyy/MM/dd');
  static String dateToString(DateTime date) {
    return _dfyyyyMMdd.format(date);
  }
}
