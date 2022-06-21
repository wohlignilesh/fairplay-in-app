import 'package:fairplay/app/networks/api_util.dart';
import 'package:fairplay/app/services/auth_service.dart';
import 'package:fairplay/app/services/log_service.dart';
import 'package:get/get.dart';

class ServiceBinding implements Bindings {
  @override
  void dependencies() {
    final apiClient = ApiUtil.getApiClient();
    Get.lazyPut<AuthService>(
      () => AuthServiceImpl(apiClient: apiClient),
      tag: (AuthService).toString(),
    );
    Get.lazyPut<LogService>(
      () => LogServiceImpl(apiClient: apiClient),
      tag: (LogService).toString(),
    );
    
  }
}