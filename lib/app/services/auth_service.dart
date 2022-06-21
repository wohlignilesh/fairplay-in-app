
import '../networks/api_client.dart';

abstract class AuthService {
  Future<dynamic> signIn(String username, String password);

  Future<dynamic> getProfile();
}

class AuthServiceImpl implements AuthService {
  late ApiClient _apiClient;

  AuthServiceImpl({required ApiClient apiClient}) {
    _apiClient = apiClient;
  }

  @override
  Future<dynamic> signIn(String username, String password) async {
    await Future.delayed(Duration(seconds: 2));
    return null;
  }

  @override
  Future<dynamic> getProfile() async {
    await Future.delayed(Duration(seconds: 2));
    //Todo: Mock data
    return null;
  }
}

