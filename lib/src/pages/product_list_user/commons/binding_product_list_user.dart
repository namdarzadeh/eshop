import 'package:get/get.dart';

import '../controllers/controller_product_list_user.dart';

class BindingProductListUser extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ControllerProductListUser>(ControllerProductListUser.new);
  }
}
