import 'package:nelac_eazy/utils/convert_date.dart';

class LoanBody {
  int? id;
  String? date;
  String? lender;
  double? amount;
  int? paid;
  LoanBody({
    this.paid,
    this.date,
    this.amount,
    this.lender,
  });
  LoanBody.fromMap(Map<dynamic, dynamic> map) {
    id = map['id'];
    date = stripDate(map['date']);
    lender = map['lender'];
    amount = map['amount'];
    paid = map['paid'];
  }
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['date'] = date;
    json['lender'] = lender;
    json['amount'] = amount;
    json['paid'] = paid;
    return json;
  }
}
