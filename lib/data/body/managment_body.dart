import '../../utils/convert_date.dart';

class ManagementBody {
  int? id;
  double? amount;
  String? type;
  String? date;
  ManagementBody({this.amount, this.type, this.date, this.id});

  ManagementBody.fromMap(Map<dynamic, dynamic> map) {
    id = map['id'];
    amount = map['amount'];
    date = stripDate(map['date']);
    type = map['type'];
  }
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['amount'] = amount;
    json['date'] = date;
    json['type'] = type;
    return json;
  }
}
