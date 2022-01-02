import 'package:dio/dio.dart';
import 'package:eshop/src/infrastructures/commons/repository_urls.dart';

import '../../shared/models/product_view_model.dart';

class RepositoriesSearch {
  Future<List<ProductViewModel>> getProducts() async {
    List<ProductViewModel> products = <ProductViewModel>[];
    try {
      final List<dynamic> _json =
          await RepositoryUrls.dioGet('${RepositoryUrls.fullBaseUrl}/product');
      products = _json.map((final e) => ProductViewModel.fromJson(e)).toList();
      return products;
    } on DioError catch (e) {
      return products;
    }
  }
}
