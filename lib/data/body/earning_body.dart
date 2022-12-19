import 'package:nelac_eazy/utils/convert_date.dart';

class EarningBody {
  int? id;
  String? date;
  String? monthYear;
  double? total;
  double? charges;

  EarningBody(
      {required this.total,
      required this.date,
      required this.monthYear,
      required this.charges});

  EarningBody.fromMap(Map<dynamic, dynamic> map) {
    date = stripDate(map['date']);
    id = map['id'];
    total = map['total'];
    charges = map['charges'];
    monthYear = map['month_year'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['date'] = date;
    json['id'] = id;
    json['total'] = total;
    json['charges'] = charges;
    json['month_year'] = monthYear;
    return json;
  }
}
