import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nelac_eazy/utils/images.dart';
import 'package:nelac_eazy/utils/navigation.dart';
import 'package:nelac_eazy/views/home/homepage.dart';
import 'package:nelac_eazy/widgets/sizedbox.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  int counter = 0;
  init() async {
    Timer.periodic(const Duration(milliseconds: 60), (timer) {
      setState(() {
        counter = timer.tick;
      });
      if (counter == 60) {
        timer.cancel();
        destroyScreen(context, const Homepage());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(Images.logo),
            h(100),
            Container(
              width: 200,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(20),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: LinearProgressIndicator(
                  minHeight: 20,
                  value: counter / 60,
                  color: Colors.white,
                  backgroundColor: Colors.black,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
