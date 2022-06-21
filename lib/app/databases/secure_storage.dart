import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final FlutterSecureStorage _storage;

  SecureStorage._internal(this._storage);

  static final SecureStorage _singleton = SecureStorage._internal(const FlutterSecureStorage());

  factory SecureStorage() {
    return _singleton;
  }

  factory SecureStorage.getInstance() {
    return _singleton;
  }

  Future<String?> read({required String key}) async{
      return await _storage.read(key: key);
  }

  Future<void> write({required String key,required String value})async {
      await _storage.write(key: key,value: value);
  }

  Future<void> remove({required String key})async {
      await _storage.delete(key: key);
  }
}
