import 'package:flutter/material.dart';
import 'package:nelac_eazy/theme/theme.dart';
import 'package:nelac_eazy/views/splash/splash.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import 'db/db.dart' as database;
import 'helper/get_di.dart' as di;

late Database db;
late SharedPreferences prefs;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  db = await database.init();
  await di.init();
  prefs = await SharedPreferences.getInstance();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Trauma Nelac Eazy',
      home: const SplashScreen(),
      theme: light.copyWith(
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: const TextStyle(color: Colors.black),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: light.primaryColor),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.black,
          iconSize: 35,
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0.0,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          titleTextStyle: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18,
              fontFamily: 'Comic'),
        ),
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: Colors.black,
        ),
      ),
    );
  }
}
