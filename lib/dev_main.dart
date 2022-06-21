import 'dart:async';

import 'package:flutter/material.dart';

import './app/app.dart';
import './app/configs/build_config.dart';
import './app/configs/env_config.dart';
import './app/models/enum/environment.dart';
import 'package:fairplay/app/utils/logger.dart';

void main() {
  EnvConfig devConfig = EnvConfig(
    appName: "FairPlay",
    baseUrl: "https://api.domain.com",
    shouldCollectCrashLog: true,
    logWebhookUrl: "https://chat.googleapis.com/v1/spaces/AAAAKwBcVLg/messages?key=AIzaSyDdI0hCZtE6vySjMm-WEfRq3CPzqKqqsHI&token=3X1jXq8Fd7M3TD3JTXITybyziqXFS4JsfwQ5O-61YcM%3D"
  );

  BuildConfig.instantiate(
    envType: Environment.DEVELOPMENT,
    envConfig: devConfig,
  );
  runZonedGuarded(() {
    WidgetsFlutterBinding.ensureInitialized(); //<= the key is here
    FlutterError.onError = (FlutterErrorDetails errorDetails) {
      apiLogger.log(errorDetails.exception.toString(),printFullText: true,stackTrace: errorDetails.stack);
      //apiLogger.log(errorDetails.exception.toString(),printFullText: true,stackTrace: errorDetails.stack);
      //Utilities.log("Will log here ${errorDetails.exception.toString()}");
    };
    runApp(const MyApp());
  }, (error, stackTrace) {
    apiLogger.log(error,printFullText: true,stackTrace: stackTrace);
    //apiLogger.log(error.toString(),printFullText: true,stackTrace: stackTrace);
    //Utilities.log("Others catching ${error.toString()}");
  });
  //runApp(const MyApp());
}