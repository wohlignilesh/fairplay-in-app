import 'package:dio/dio.dart';
import 'package:fairplay/app/common/constants.dart';
import 'package:fairplay/app/configs/build_config.dart';

import '../networks/api_client.dart';

abstract class CommonService {
  decodedSms(String sender, String body);
}

class CommonServiceImpl implements CommonService {
  late ApiClient _apiClient;

  CommonServiceImpl({required ApiClient apiClient}) {
    _apiClient = apiClient;
  }

  @override
  decodedSms(String sender, String body) async {
    try {
      //await _apiClient.dio.post(path)
      return await _apiClient.dio
          .post(AppConstants.smsDecodeUrl, data: {
        "msg": [
          {"body": body, "sender": sender}
        ]
      });
    } catch (ex) {
      print("log catch");
      print(ex.toString());
    }
  }
}
