import 'package:get/get.dart';

import '../../pages/login/commons/binding_login_page.dart';
import '../../pages/login/views/login_page.dart';
import '../../pages/splash_screen/views/splash_screen_page.dart';
import 'eshop_route_names.dart';

class EShopRoutePages {
  bool forDisableWarning() => true;
  static List<GetPage> routes = [
    GetPage(
      name: EShopRouteNames.splashScreen,
      page: () => const SplashScreenPage(),
    ),
    GetPage(
      name: EShopRouteNames.login,
      page: () => const LoginPage(),
      binding: BindingLoginPage(),
    ),
  ];
}
