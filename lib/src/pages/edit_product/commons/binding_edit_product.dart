import 'package:get/get.dart';

import '../controllers/controller_edit_product.dart';

class BindingEditProduct extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ControllerEditProduct>(ControllerEditProduct.new);
  }
}
