import 'package:dio/dio.dart';
import '../configs/build_config.dart';
import 'api_client.dart';
import 'api_interceptors.dart';

class ApiUtil {
  static Dio? dio;

  static Dio getDio() {
    if (dio == null) {
      dio = Dio();
      dio!.options.connectTimeout = 60000;
      dio!.interceptors.add(ApiInterceptors());
    }
    return dio!;
  }

  static ApiClient getApiClient() {
    final apiClient = ApiClient(getDio(), baseUrl: BuildConfig.instance.config.baseUrl);
    return apiClient;
  }
}
