import 'dart:convert';
import 'dart:typed_data';

import 'package:get/get.dart';

import '../../shared/models/product_view_model.dart';
import '../repositories/repositories_product_list_user.dart';

class ControllerProductListUser extends GetxController {
  final RepositoriesProductListUser _repository = RepositoriesProductListUser();
  RxList<ProductViewModel> products = <ProductViewModel>[].obs;
  RxInt number = 0.obs;

  Future<int> _getProducts() async {
    products.value = await _repository.getProducts();
    return 1;
  }

  Uint8List base64ToByte(final String pic) {
    final decodedBytes = base64Decode(pic);
    return decodedBytes;
  }

  @override
  void onInit() async {
    await _getProducts();
    super.onInit();
  }
}
