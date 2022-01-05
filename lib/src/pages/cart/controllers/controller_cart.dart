import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../eshop.dart';
import '../../shared/models/product_dto.dart';
import '../../shared/models/product_view_model.dart';
import '../repositories/repositories_cart.dart';

class ControllerCart extends GetxController {
  final RepositoriesCart _repository = RepositoriesCart();
  RxList<ProductViewModel> products = <ProductViewModel>[].obs;
  RxInt number = 0.obs;
  RxInt totalPrice = 0.obs;

  Future<void> _getProducts() async {
    final _result = await _repository.getProducts();
    _result.fold((final l) {}, (final r) {
      products.value = r;
    });
  }

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

  int checkInstock(final List<dynamic> product, final int number) {
    int _result = 0;
    products.forEach((final element) {
      if (element.name == product[0]) {
        if (element.instock >= number) {
          _result = 1;
        }
      }
    });
    return _result;
  }

  void _calculate() {
    number.value = 0;
    totalPrice.value = 0;
    EShopParameters.orders.forEach((final element) {
      number.value = number.value + element[2] as int;
      totalPrice.value = totalPrice.value + (element[1] * element[2]) as int;
    });
  }

  Future<void> _editProduct(
      final ProductViewModel product, final int number) async {
    final ProductDto productDto = ProductDto(
        isactive: product.isactive,
        name: product.name,
        price: product.price,
        instock: product.instock - number,
        pic: product.pic,
        details: product.details,
        tag: product.tag);
    await _repository.editProduct(product.id, productDto);
  }

  Future<void> submitOrder() async {
    EShopParameters.orders.forEach((final elementOrders) {
      products.forEach((final elementProduct) {
        if (elementOrders[0] == elementProduct.name) {
          _editProduct(elementProduct, elementOrders[2]);
        }
      });
    });
    EShopParameters.orders = <List<dynamic>>[].obs;
    _calculate();
    await _getProducts();
    ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
        content: Text(
            LocaleKeys.eshop_business_exception_submit_order_successful.tr)));
  }

  Future<void> deleteOrder() async {
    EShopParameters.orders = <List<dynamic>>[].obs;
    _calculate();
    ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
        content: Text(
            LocaleKeys.eshop_business_exception_delete_order_successful.tr)));
    Get.back();
  }

  @override
  void onInit() async {
    _calculate();
    await _getProducts();
    super.onInit();
  }
}
