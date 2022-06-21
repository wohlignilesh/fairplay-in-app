
import 'package:dio/dio.dart';
import 'package:fairplay/app/configs/build_config.dart';

import '../networks/api_client.dart';

abstract class LogService {
  sendLog(String error);
}

class LogServiceImpl implements LogService {
  late ApiClient _apiClient;

  LogServiceImpl({required ApiClient apiClient}) {
    _apiClient = apiClient;
  }
  
  @override
  sendLog(String error) async{
    try{
    await _apiClient.dio.post(
      BuildConfig.instance.config.logWebhookUrl,
      data:{"text":error}
      );
      }
      catch(ex){
        print("log catch");
        print(ex.toString());
      }
  }
  


}

