import 'dart:convert';
import 'dart:typed_data';

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
  RxBool localPic = true.obs;
  late Uint8List imageBytes;

  Uint8List base64ToByte(final String pic) {
    final decodedBytes = base64Decode(pic);
    return decodedBytes;
  }

  @override
  void onInit() async {
    product.value = await Get.arguments as ProductViewModel;
    imageBytes = base64ToByte(product.value.pic);
    localPic.value = false;
    super.onInit();
  }
}
