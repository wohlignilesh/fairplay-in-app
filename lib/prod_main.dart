import 'package:flutter/material.dart';

import './app/app.dart';
import './app/configs/build_config.dart';
import './app/configs/env_config.dart';
import './app/models/enum/environment.dart';

void main() {
  EnvConfig prodConfig = EnvConfig(
    appName: "FairPlay",
    baseUrl: "https://api.domain.com",
    shouldCollectCrashLog: true,
    logWebhookUrl: "https://chat.googleapis.com/v1/spaces/AAAAKwBcVLg/messages?key=AIzaSyDdI0hCZtE6vySjMm-WEfRq3CPzqKqqsHI&token=3X1jXq8Fd7M3TD3JTXITybyziqXFS4JsfwQ5O-61YcM%3D"
  );

  BuildConfig.instantiate(
    envType: Environment.PRODUCTION,
    envConfig: prodConfig,
  );

  runApp(const MyApp());
}