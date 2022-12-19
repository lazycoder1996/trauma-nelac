import 'package:flutter/cupertino.dart';

double convert({String? amount, TextEditingController? text}) {
  return double.parse(amount ?? text!.text.trim());
}
