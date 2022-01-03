import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../eshop.dart';
import '../../shared/models/product_view_model.dart';
import '../repositories/repositories_product_list_user.dart';

class ControllerProductListUser extends GetxController {
  GlobalKey<ScaffoldState> scafoldKey = GlobalKey<ScaffoldState>();
  final RepositoriesProductListUser _repository = RepositoriesProductListUser();
  RxList<ProductViewModel> products = <ProductViewModel>[].obs;
  RxBool searchMode = false.obs;

  Future<int> _getProducts() async {
    products.value = await _repository.getProducts();
    return 1;
  }

  Uint8List base64ToByte(final String pic) {
    final decodedBytes = base64Decode(pic);
    return decodedBytes;
  }

  Future<void> searchClick() async {
    final List<ProductViewModel> backProducts =
        await Get.toNamed(EShopRouteNames.search);
    if (backProducts.isNotEmpty) {
      products.value = backProducts;
      searchMode.value = true;
    }
  }

  Future<void> clearSearchClick() async {
    await _getProducts();
    searchMode.value = false;
  }

  Future<void> clearFilterClick() async {
    await _getProducts();
    EShopParameters.filterResult = [false, 0, 1000000000, false];
    EShopParameters.filterMode.value = false;
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
    await _getProducts();
  }

  Future<void> showProductClick(final ProductViewModel product) async {
    await Get.toNamed(EShopRouteNames.showProduct, arguments: product);
    await _getProducts();
  }

  @override
  void onInit() async {
    await _getProducts();
    super.onInit();
  }
}
