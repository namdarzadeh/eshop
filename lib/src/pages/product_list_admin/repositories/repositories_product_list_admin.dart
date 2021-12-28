import 'package:dio/dio.dart';
import 'package:eshop/src/pages/shared/models/product_dto.dart';

import '../../../infrastructures/commons/repository_urls.dart';
import '../../shared/models/product_view_model.dart';

class RepositoriesProductListAdminPage {
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

  Future<int> putProduct(final int id, final ProductDto productDto) async {
    try {
      final _json = await RepositoryUrls.dioPut(
          '${RepositoryUrls.fullBaseUrl}/product',
          id,
          ProductDto.toJson(productDto));
      return 1;
    } on DioError catch (e) {
      return 0;
    }
  }

  Future<int> deleteProduct(final int id) async {
    try {
      final _json = await RepositoryUrls.dioDelete(
          '${RepositoryUrls.fullBaseUrl}/product', id);
      return 1;
    } on DioError catch (e) {
      return 0;
    }
  }
}
