import 'package:get/get.dart';

import '../../pages/shared/models/person_view_model.dart';
import '../routes/eshop_route_pages.dart';

mixin EShopParameters {
  static late String fullBaseUrl;
  static List<GetPage> pages = EShopRoutePages.routes;
  static late PersonViewModel localPersonViewModel;
  static String defaultLanguage = 'fa';
  static List filterResult = [0, 1000000000, false];
  static RxBool filterMode = false.obs;
  static RxList<List<dynamic>> orders = <List<dynamic>>[].obs;
}
