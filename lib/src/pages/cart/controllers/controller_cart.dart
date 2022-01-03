import 'package:get/get.dart';

import '../../../../eshop.dart';

class ControllerCart extends GetxController {
  RxInt number = 0.obs;
  RxInt totalPrice = 0.obs;

  void updateCart(final List<dynamic> product, final int number) {
    if (number == 0) {
      EShopParameters.orders.remove(product);
    } else {
      EShopParameters.orders.forEach((final element) {
        if (element[0] == product[0]) {
          element[2] = number;
        }
      });
    }
    _calculate();
  }

  void _calculate() {
    number.value = 0;
    totalPrice.value = 0;
    EShopParameters.orders.forEach((final element) {
      number.value = number.value + element[2] as int;
      totalPrice.value = totalPrice.value + (element[1] * element[2]) as int;
    });
  }

  @override
  void onInit() {
    _calculate();
    super.onInit();
  }
}
