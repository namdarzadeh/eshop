import 'package:get/get.dart';

import '../controllers/controller_login_page.dart';

class BindingLoginPage extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ControllerLoginPage>(ControllerLoginPage.new);
  }
}
