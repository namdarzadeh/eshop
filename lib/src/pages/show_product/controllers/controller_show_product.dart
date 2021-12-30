import 'package:get/get.dart';

import '../../shared/models/product_view_model.dart';

class ControllerShowProduct extends GetxController {
  Rx<ProductViewModel> product = ProductViewModel(
          id: 0,
          isactive: 0,
          name: '',
          price: 0,
          instock: 0,
          pic: '',
          details: '',
          tag: '')
      .obs;
  RxInt number = 0.obs;

  @override
  void onInit() async {
    product.value = await Get.arguments as ProductViewModel;
    super.onInit();
  }
}
