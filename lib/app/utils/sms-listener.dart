import 'dart:convert';
import 'package:fairplay/app/databases/secure_storage.dart';
import 'package:fairplay/app/services/common_service.dart';
import 'package:flutter/foundation.dart';
import 'package:get/instance_manager.dart';
import '../models/dto/sms.dart';
import 'package:flutter/material.dart';
import 'package:telephony/telephony.dart';
class ListenSms {
  Future<void> startListening() async {
    final telephony = Telephony.instance;
    try {
      //await getIt<StorageServices>().remove(key: "sms");
      telephony.listenIncomingSms(
          onNewMessage: (SmsMessage message) async {
            try {
              SecureStorage _storage = SecureStorage.getInstance();
              String? sender =
                  await _storage.read(key: "sender");
              if (!message.address
                  .toString()
                  .toUpperCase()
                  .contains(sender.toString().toUpperCase()) && !kDebugMode) {
                return;
              }
              final logService = Get.find<CommonService>(tag: (CommonService).toString());
              dynamic msgObj = await logService.decodedSms(message.address.toString(), message.body.toString());
              Sms smsObj =Sms.fromJson(msgObj["data"][0]);
              //ExtractedMessage smsObj = ExtractedMessage(sender: "sender", type: "type", no: "no", balance: "balance", money: "money", typeOfTransaction: "typeOfTransaction", refno: "refno", date: "date");
              if (smsObj.refno != "" && smsObj.money != "") {
                List<Sms> msgList;
                String? sms = await _storage.read(key: "sms");
                if (sms == null || sms == "") {
                  msgList = [];
                } else {
                  List<dynamic> jsonData = json.decode(sms.toString());
                  msgList = jsonData
                      .map((e) => Sms.fromJson(e))
                      .toList();
                }
                msgList.add(smsObj);
                String msgStr = Sms.encode(msgList);
                await _storage.write(key: "sms", value: msgStr);
              } else {
                debugPrint("ref no is blank");
              }
            } catch (e) {
              debugPrint("listen SMS error" + e.toString());
            }
          },
          onBackgroundMessage: backgrounMessageHandler,
          listenInBackground: true);
    } catch (e) {
      debugPrint("message catch " '${e.toString()}');
    }
  }
}

backgrounMessageHandler(SmsMessage message) async {
  try {
    debugPrint("onBackgroundMessage called");
    SecureStorage _storage = SecureStorage.getInstance();
    //StorageServices storage = StorageServices(const FlutterSecureStorage());
    String? sender = await _storage.read(key: "sender");
    if (!message.address
        .toString()
        .toUpperCase()
        .contains(sender.toString().toUpperCase()) && !kDebugMode) {
      return;
    }
    final logService = Get.find<CommonService>(tag: (CommonService).toString());
    dynamic msgObj = await logService.decodedSms(message.address.toString(), message.body.toString());
    Sms smsObj = Sms.fromJson(msgObj["data"][0]);
    if (smsObj.refno != "" && smsObj.money != "") {
      List<Sms> msgList;
      String? sms = await _storage.read(key: "sms");
      if (sms == null || sms == "") {
        msgList = [];
      } else {
        List<dynamic> jsonData = json.decode(sms.toString());
        msgList = jsonData.map((e) => Sms.fromJson(e)).toList();
      }
      msgList.add(smsObj);
      String msgStr = Sms.encode(msgList);
      await _storage.write(key: "sms", value: msgStr);
    }
  } catch (e) {
    debugPrint("message BG catch " '${e.toString()}');
  }
}