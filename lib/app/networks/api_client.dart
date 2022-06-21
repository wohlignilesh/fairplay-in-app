import 'package:dio/dio.dart';
class ApiClient {
  Dio dio;
  String baseUrl;
  // ignore: no_leading_underscores_for_local_identifiers
  ApiClient(this.dio, {required this.baseUrl});
}
