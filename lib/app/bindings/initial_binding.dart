import 'package:get/get.dart';
import 'service_binding.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    ServiceBinding().dependencies();
  }
}