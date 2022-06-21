// ignore_for_file: camel_case_types

import 'package:fairplay/app/ui/base/state_view.dart';
import 'package:fairplay/app/ui/pages/splash/splash_controller.dart';
import 'package:flutter/material.dart';

class SplashView extends StateView<Splash,SplashController> {
  
  // ignore: use_key_in_widget_constructors
  const SplashView(SplashController state):super(state);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'fair',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color.fromRGBO(111, 172, 71, 1),
                      fontSize: 50,
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.italic),
                ),
                Text(
                  'play',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color.fromRGBO(242, 109, 37, 1),
                      fontSize: 50,
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.italic),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Text(
              ' Greater Odds Greater Winnings',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
