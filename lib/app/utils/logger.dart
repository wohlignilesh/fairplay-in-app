import 'dart:developer' as developer;
import 'dart:io';
import 'package:device_info/device_info.dart';
import 'package:fairplay/app/services/log_service.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

var logger = Logger();
var apiLogger = ApiLogger();

class ApiLogger {
  /// Log a message at level verbose.
  void v(dynamic message) {
    _print("🤍 VERBOSE: $message");
  }

  /// Log a message at level debug.
  void d(dynamic message) {
    _print("💙 DEBUG: $message");
  }

  /// Log a message at level info.
  void i(dynamic message) {
    _print("💚️ INFO: $message");
  }

  /// Log a message at level warning.
  void w(dynamic message) {
    _print("💛 WARNING: $message");
  }

  /// Log a message at level error.
  void e(dynamic message) {
    _print("❤️ ERROR: $message");
  }

  void _print(dynamic message) {
    if (kDebugMode) {
      print("$message");
    }
  }

  void _log(dynamic message,StackTrace? stackTrace) async{
    if (kDebugMode) {
      developer.log("$message");
    }
    if(stackTrace!=null){
      final logService = Get.find<LogService>(tag: (LogService).toString());
      String deviceName="";
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      if(Platform.isAndroid){
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        deviceName="${androidInfo.board} - ${androidInfo.brand}(${androidInfo.model})";
      }
      String log="Device: $deviceName\nError: $message\nStackTrace: ${stackTrace.toString()}";
      if(log.length>4000){
        log=log.substring(0,3999);
      }
      logService.sendLog(log);
    }
  }

  void log(dynamic message,
      {bool printFullText = false, StackTrace? stackTrace}) {
    if (printFullText) {
      _log(message,stackTrace);
    } else {
      _print(message);
    }
    if (stackTrace != null) {
      _print(stackTrace);
    }
  }
}
