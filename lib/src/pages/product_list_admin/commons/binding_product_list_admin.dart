import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_instance/src/extension_instance.dart';

import '../controllers/controller_product_list_admin.dart';

class BindingProductListAdmin extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ControllerProductListAdmin>(ControllerProductListAdmin.new);
  }
}
