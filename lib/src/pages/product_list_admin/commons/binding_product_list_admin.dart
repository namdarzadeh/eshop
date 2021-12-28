import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_instance/src/extension_instance.dart';

import '../controllers/controller_product_list_admin.dart';

class BindingProductListAdminPage extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ControllerProductListAdminPage>(
        ControllerProductListAdminPage.new);
  }
}
