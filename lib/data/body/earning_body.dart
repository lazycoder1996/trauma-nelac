import 'package:nelac_eazy/utils/convert_date.dart';

class EarningBody {
  int? id;
  String? date;
  double? total;
  double? charges;
  EarningBody({required this.total, required this.date, required this.charges});
  EarningBody.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    total = json['total'];
    charges = json['charges'];
  }
  EarningBody.fromMap(Map<dynamic, dynamic> map) {
    date = stripDate(map['date']);
    id = map['id'];
    total = map['total'];
    charges = map['charges'];
  }
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['date'] = date;
    json['id'] = id;
    json['total'] = total;
    json['charges'] = charges;
    return json;
  }
}
