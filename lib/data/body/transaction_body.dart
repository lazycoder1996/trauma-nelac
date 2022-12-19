import 'package:nelac_eazy/utils/convert_date.dart';

class TransactionBody {
  int? id;
  String? sender;
  String? receiver;
  int? paid;
  double? amount;
  double? charges;
  String? date;
  String? type;
  String? monthYear;
  TransactionBody({
    this.id,
    this.date,
    this.paid,
    this.receiver,
    this.sender,
    this.charges,
    this.amount,
    this.type,
    this.monthYear,
  });
  TransactionBody.fromMap(Map<dynamic, dynamic> json) {
    id = json['id'];
    sender = json['sender'];
    receiver = json['receiver'];
    paid = json['paid'];
    amount = json['amount'];
    charges = json['charges'];
    date = stripDate(json['date']);
    type = json['type'];
    monthYear = json['month_year'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    // json['id'] = id;
    json['sender'] = sender;
    json['receiver'] = receiver;
    json['paid'] = paid;
    json['amount'] = amount;
    json['charges'] = charges;
    json['date'] = date;
    json['type'] = type;
    json['month_year'] = monthYear;
    return json;
  }
}
