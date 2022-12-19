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
  TransactionBody({
    this.id,
    this.date,
    this.paid,
    this.receiver,
    this.sender,
    this.charges,
    this.amount,
    this.type,
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
    return json;
  }
}
