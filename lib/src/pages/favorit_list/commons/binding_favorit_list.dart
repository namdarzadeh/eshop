import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_instance/src/extension_instance.dart';

import '../controllers/controller_favorit_list.dart';

class BindingFavoritList extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ControllerFavoritList>(ControllerFavoritList.new);
  }
}
