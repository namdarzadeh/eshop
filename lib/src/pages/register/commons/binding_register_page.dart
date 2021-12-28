import 'package:get/get.dart';

import '../controllers/controller_register_page.dart';

class BindingRegisterPage extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ControllerRegisterPage>(ControllerRegisterPage.new);
  }
}
