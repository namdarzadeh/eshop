import 'package:get/get.dart';

import '../../pages/shared/models/person_view_model.dart';
import '../routes/eshop_route_pages.dart';

mixin EShopParameters {
  static late String fullBaseUrl;
  static List<GetPage> pages = EShopRoutePages.routes;
  static late PersonViewModel localPersonViewModel;
}
