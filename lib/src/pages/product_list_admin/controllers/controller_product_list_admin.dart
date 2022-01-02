import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../eshop.dart';
import '../../shared/models/product_dto.dart';
import '../../shared/models/product_view_model.dart';
import '../repositories/repositories_product_list_admin.dart';
import '../views/dialogs/delete_product_dialog.dart';

class ControllerProductListAdmin extends GetxController {
  GlobalKey<ScaffoldState> scafoldKey = GlobalKey<ScaffoldState>();
  final RepositoriesProductListAdmin _repository =
      RepositoriesProductListAdmin();
  RxList<ProductViewModel> products = <ProductViewModel>[].obs;
  RxBool searchMode = false.obs;

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

  Future<void> editProductClick(final int id) async {
    final int _result =
        await Get.toNamed(EShopRouteNames.editProduct, arguments: id);
    if (_result == 1) {
      await _getProducts();
    }
  }

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

  Future<void> addProductClick() async {
    final int _result = await Get.toNamed(EShopRouteNames.addProduct);
    if (_result == 1) {
      await _getProducts();
    }
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

  @override
  void onInit() async {
    await _getProducts();
    super.onInit();
  }
}
