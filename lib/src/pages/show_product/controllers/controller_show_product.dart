import 'dart:convert';
import 'dart:typed_data';

import 'package:get/get.dart';

import '../../../../eshop.dart';
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
  RxBool localPic = true.obs;
  late Uint8List imageBytes;

  Uint8List base64ToByte(final String pic) {
    final decodedBytes = base64Decode(pic);
    return decodedBytes;
  }

  int getnumber(final ProductViewModel product) {
    int _result = 0;
    EShopParameters.orders.forEach((final element) {
      if (element[0] == product.name) {
        _result = element[2];
      }
    });
    return _result;
  }

  void updateCart(final ProductViewModel product, final int number) {
    int _result = 0;
    EShopParameters.orders.forEach((final element) {
      if (element[0] == product.name) {
        element[2] = number;
        _result = 1;
      }
    });
    if (_result == 0) {
      EShopParameters.orders.add([product.name, product.price, number]);
    }
  }

  Future<void> cartClick() async {
    await Get.toNamed(EShopRouteNames.cart);
    number.value = getnumber(product.value);
  }

  @override
  void onInit() async {
    product.value = await Get.arguments as ProductViewModel;
    imageBytes = base64ToByte(product.value.pic);
    localPic.value = false;
    number.value = getnumber(product.value);
    super.onInit();
  }
}
