import 'package:eshop/src/pages/search/repositories/repositories_search.dart';
import 'package:eshop/src/pages/shared/models/product_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ControllerSearch extends GetxController {
  final TextEditingController controllerSearch = TextEditingController();
  final RepositoriesSearch _repository = RepositoriesSearch();
  List<ProductViewModel> products = <ProductViewModel>[];
  List<ProductViewModel> matchProducts = <ProductViewModel>[];

  Future<void> _getProducts() async {
    products = await _repository.getProducts();
  }

  Future<void> checkInProduct() async {
    products.forEach((final element) {
      int match = 0;
      final List<String> productSplit = element.name.split(' ') +
          element.details.split(' ') +
          element.tag.split(' #');
      for (String element in productSplit) {
        if (element == controllerSearch.text) {
          match = 1;
        }
      }
      if (match == 1) {
        matchProducts.add(element);
      }
      match = 0;
    });
  }

  Future<void> searchClick() async {
    await _getProducts();
    await checkInProduct();
    Get.back(result: matchProducts);
  }

  void clearClick() {
    controllerSearch.text = '';
  }
}
