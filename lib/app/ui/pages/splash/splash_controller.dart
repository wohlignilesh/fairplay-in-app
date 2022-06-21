// ignore_for_file: camel_case_types

import 'dart:io';

import 'package:fairplay/app/databases/secure_storage.dart';
import 'package:fairplay/app/routes/app_pages.dart';
import 'package:fairplay/app/ui/pages/splash/splash_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:telephony/telephony.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => SplashController();
}

class SplashController extends State<Splash> {
  @override
  Widget build(BuildContext context) => SplashView(this);

  @override
  void initState() {
    super.initState();
    getSmsPermission();
  }
  
  final telephony = Telephony.instance;
  int counter = 0;
  
  navigateLogin() async {
    ListenSms().startListen();
    SecureStorage _storage = SecureStorage.getInstance();
    String? sender = await _storage.read(key: "sender");
    if (sender == null || sender.toString() == "") {
      await _storage.write(key: "sender", value: "RBLBNK");
    }
    String? status = await _storage.read(key: "isLoggedIn");
    String? accessToken = await _storage.read(key: "accessToken");
    if (status.toString() == 'true' && accessToken.toString() != "") {
      Get.offAll(() => AppPages.DashboardRoute);
      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) => const Dashboard(),
      //     ));
    } else {
      Get.offAll(()=>AppPages.LoginRoute);
      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) => const LoginPage(),
      //     ));
    }
  }

  Future<void> getSmsPermission() async {
    try {
      counter += 1;
      final bool? result = await telephony.requestPhoneAndSmsPermissions;
      if (result != null && result || kIsWeb) {
        navigateLogin();
      }
    } catch (e) {
      if (kIsWeb) {
        navigateLogin();
      } else if (counter == 1) {
        showMsg();
      } else {
        hintpermission();
      }
    }
  }

  showMsg() async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => AlertDialog(
        title: const Text("Permission Required!"),
        content: Text("To read the transactional messages this permission is mandatory ${counter.toString()}"),
        actions: <Widget>[
          TextButton(
              onPressed: () {
                Navigator.pop(context);
                getSmsPermission();
              },
              child: const Text("Okay"))
        ],
      ),
    );
  }

  hintpermission() async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => AlertDialog(
        title: const Text("Permission Required!"),
        content: const Text("Go To App Setting >> Permission >> SMS >> Allow"),
        actions: <Widget>[
          TextButton(
              onPressed: () {
                Navigator.pop(context);
                openAppSettings();
                exit(0);
              },
              child: const Text("Okay"))
        ],
      ),
    );
  }
}
