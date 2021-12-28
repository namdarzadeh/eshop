import 'package:get/get.dart';

import '../controllers/controller_register.dart';

class BindingRegister extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ControllerRegister>(ControllerRegister.new);
  }
}
