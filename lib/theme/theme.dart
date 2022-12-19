import 'package:flutter/material.dart';

Color primaryColor = const Color(0x00000000);

Map<int, Color> colors = {
  for (var item in List.generate(10, (index) {
    return index == 0 ? 50 : index * 100;
  }))
    item: primaryColor.withOpacity(item == 50 ? 0.1 : item / 1000 + 0.1)
};
MaterialColor primarySwatch = MaterialColor(0xFF880E4F, colors);

ThemeData light = ThemeData(
  primaryColor: const Color(0x00000000),
  primarySwatch: primarySwatch,
  fontFamily: 'Comic',
);
