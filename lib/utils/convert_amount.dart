import 'package:flutter/cupertino.dart';

double convert({String? amount, TextEditingController? text}) {
  return double.tryParse(amount ?? text!.text.trim()) ?? 0;
}
