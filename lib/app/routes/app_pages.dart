import '../ui/pages/splash/splash_controller.dart';
import 'package:get/get.dart';


abstract class _Paths {
  static const SPLASH = '/splash';
  static const LOGIN = '/login';
  static const HOME = '/home';
} 

class AppPages {
  AppPages._();

  static const SplashRoute = _Paths.SPLASH;
  static const LoginRoute = _Paths.SPLASH;
  static const DashboardRoute = _Paths.SPLASH;

  static final routes = [
    GetPage(
      name: SplashRoute,
      page: () => Splash()
    ),
    GetPage(
      name: LoginRoute,
      page: () => Splash()
    ),
    GetPage(
      name: DashboardRoute,
      page: () => Splash()
    ),
    
  ];
}
