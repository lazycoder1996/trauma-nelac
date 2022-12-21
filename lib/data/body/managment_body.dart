import '../../utils/convert_date.dart';

class ManagementBody {
  int? id;
  double? amount;
  String? type;
  String? date;
  String? merchantName;

  ManagementBody(
      {this.amount, this.merchantName, this.type, this.date, this.id});

  ManagementBody.fromMap(Map<dynamic, dynamic> map) {
    id = map['id'];
    amount = map['amount'];
    date = stripDate(map['date']);
    type = map['type'];
    merchantName = map['merchant_name'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['amount'] = amount;
    json['date'] = date;
    json['type'] = type;
    json['merchant_name'] = merchantName;
    return json;
  }
}
