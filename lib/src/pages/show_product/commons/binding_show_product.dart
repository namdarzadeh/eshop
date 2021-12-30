import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_instance/src/extension_instance.dart';

import '../controllers/controller_show_product.dart';

class BindingShowProduct extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ControllerShowProduct>(ControllerShowProduct.new);
  }
}
