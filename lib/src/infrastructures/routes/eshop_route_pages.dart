import 'package:get/get.dart';

import '../../pages/add_product/commons/binding_add_product.dart';
import '../../pages/add_product/views/add_product_page.dart';
import '../../pages/cart/commons/binding_cart.dart';
import '../../pages/cart/views/cart_page.dart';
import '../../pages/edit_product/commons/binding_edit_product.dart';
import '../../pages/edit_product/views/edit_product_page.dart';
import '../../pages/edit_profile/commons/binding_edit_profile.dart';
import '../../pages/edit_profile/views/edit_profile_page.dart';
import '../../pages/favorit_list/commons/binding_favorit_list.dart';
import '../../pages/favorit_list/views/favorit_list_page.dart';
import '../../pages/login/commons/binding_login.dart';
import '../../pages/login/views/login_page.dart';
import '../../pages/product_list_admin/commons/binding_product_list_admin.dart';
import '../../pages/product_list_admin/views/product_list_admin_page.dart';
import '../../pages/product_list_user/commons/binding_product_list_user.dart';
import '../../pages/product_list_user/views/product_list_user_page.dart';
import '../../pages/register/commons/binding_register.dart';
import '../../pages/register/views/register_page.dart';
import '../../pages/remember_password/commons/binding_remember_password.dart';
import '../../pages/remember_password/views/remember_password_page.dart';
import '../../pages/search/commons/binding_search.dart';
import '../../pages/search/views/search_page.dart';
import '../../pages/show_product/commons/binding_show_product.dart';
import '../../pages/show_product/views/show_product_page.dart';
import '../../pages/splash_screen/views/splash_screen_page.dart';
import '../../pages/users_list/commons/binding_users_list.dart';
import '../../pages/users_list/views/users_list_page.dart';
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
    GetPage(
      name: EShopRouteNames.addProduct,
      page: () => const AddProductPage(),
      binding: BindingAddProduct(),
    ),
    GetPage(
      name: EShopRouteNames.editProduct,
      page: () => const EditProductPage(),
      binding: BindingEditProduct(),
    ),
    GetPage(
      name: EShopRouteNames.showProduct,
      page: () => const ShowProductPage(),
      binding: BindingShowProduct(),
    ),
    GetPage(
      name: EShopRouteNames.cart,
      page: () => const CartPage(),
      binding: BindingCart(),
    ),
    GetPage(
      name: EShopRouteNames.rememberPassword,
      page: () => const RememberPasswordPage(),
      binding: BindingRememberPassword(),
    ),
    GetPage(
      name: EShopRouteNames.editProfile,
      page: () => const EditProfilePage(),
      binding: BindingEditProfile(),
    ),
    GetPage(
      name: EShopRouteNames.search,
      page: () => const SearchPage(),
      binding: BindingSearch(),
    ),
    GetPage(
      name: EShopRouteNames.usersList,
      page: () => const UsersListPage(),
      binding: BindingUsersList(),
    ),
    GetPage(
      name: EShopRouteNames.favoritList,
      page: () => const FavoritListPage(),
      binding: BindingFavoritList(),
    ),
  ];
}
