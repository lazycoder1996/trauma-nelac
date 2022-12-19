import 'package:intl/intl.dart';

date([String? date]) {
  return "'${DateFormat().add_yMMMMd().format(
        date == null ? DateTime.now() : DateTime.parse(date),
      )}'";
}

stripDate(String date) {
  return date.replaceAll("'", '');
}
