import 'package:get/get.dart';

import '../controllers/controller_login.dart';

class BindingLogin extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ControllerLogin>(ControllerLogin.new);
  }
}
