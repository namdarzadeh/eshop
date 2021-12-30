import 'package:get/get.dart';

import '../../shared/models/product_view_model.dart';

class ControllerCart extends GetxController {
  RxList<ProductViewModel> orders = <ProductViewModel>[].obs;
  RxInt number = 0.obs;

  @override
  void onInit() {
    orders.value.add(ProductViewModel(
        id: 1,
        isactive: 1,
        name: 'erwfwe',
        price: 200,
        instock: 2,
        pic: 'pic',
        details: 'details',
        tag: 'tag'));
    super.onInit();
  }
}
