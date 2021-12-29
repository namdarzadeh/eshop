import 'package:get/get.dart';

import '../controllers/controller_add_product.dart';

class BindingAddProduct extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ControllerAddProduct>(ControllerAddProduct.new);
  }
}
