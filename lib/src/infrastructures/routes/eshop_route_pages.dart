import 'package:eshop/src/pages/product_list_admin/commons/binding_product_list_admin.dart';
import 'package:eshop/src/pages/product_list_admin/views/product_list_admin_page.dart';
import 'package:eshop/src/pages/product_list_user/commons/binding_product_list_user.dart';
import 'package:eshop/src/pages/product_list_user/views/product_list_user_page.dart';
import 'package:eshop/src/pages/register/commons/binding_register.dart';
import 'package:get/get.dart';

import '../../pages/login/commons/binding_login.dart';
import '../../pages/login/views/login_page.dart';
import '../../pages/register/views/register_page.dart';
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
      binding: BindingLogin(),
    ),
    GetPage(
      name: EShopRouteNames.register,
      page: () => const RegisterPage(),
      binding: BindingRegister(),
    ),
    GetPage(
      name: EShopRouteNames.productListAdmin,
      page: () => const ProductListAdminPage(),
      binding: BindingProductListAdmin(),
    ),
    GetPage(
      name: EShopRouteNames.productListUser,
      page: () => const ProductListUserPage(),
      binding: BindingProductListUser(),
    ),
  ];
}
