import 'package:eshop/eshop.dart';
import 'package:eshop/src/pages/product_list_admin/views/dialogs/delete_product_dialog.dart';
import 'package:eshop/src/pages/shared/models/product_dto.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../shared/models/product_view_model.dart';
import '../repositories/repositories_product_list_admin.dart';

class ControllerProductListAdminPage extends GetxController {
  final RepositoriesProductListAdminPage _repository =
      RepositoriesProductListAdminPage();
  RxList<ProductViewModel> products = <ProductViewModel>[].obs;
  late ProductViewModel productViewModel;

  Future<int> _getProducts() async {
    products.value = await _repository.getProducts();
    return 1;
  }

  Future<void> editProduct(final bool i, final ProductViewModel product) async {
    if (i) {
      final ProductDto _product = ProductDto(
          isactive: 1,
          name: product.name,
          price: product.price,
          instock: product.instock,
          pic: product.pic,
          details: product.details,
          tag: product.tag);
      await _repository.putProduct(product.id, _product);
      await _getProducts();
    } else {
      final ProductDto _product = ProductDto(
          isactive: 0,
          name: product.name,
          price: product.price,
          instock: product.instock,
          pic: product.pic,
          details: product.details,
          tag: product.tag);
      await _repository.putProduct(product.id, _product);
      await _getProducts();
    }
  }

  void editProductClick(final int id) {}

  Future<void> deleteProductClick(final int id) async {
    final int _result = await _repository.deleteProduct(id);
    if (_result == 1) {
      await Get.dialog(DeleteProductDialog());
    } else {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content:
              Text(LocaleKeys.eshop_business_exception_http_error_500.tr)));
    }
    await _getProducts();
  }

  @override
  void onInit() async {
    await _getProducts();
    super.onInit();
  }
}
