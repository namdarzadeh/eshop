import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_instance/src/extension_instance.dart';

import '../controllers/controller_users_list.dart';

class BindingUsersList extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ControllerUsersList>(ControllerUsersList.new);
  }
}
