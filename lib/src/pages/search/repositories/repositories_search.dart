import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../infrastructures/commons/repository_urls.dart';
import '../../shared/models/product_view_model.dart';

class RepositoriesSearch {
  Future<Either<int?, List<ProductViewModel>>> getProducts() async {
    List<ProductViewModel> products = <ProductViewModel>[];
    try {
      final List<dynamic> _json =
          await RepositoryUrls.dioGet('${RepositoryUrls.fullBaseUrl}/product');
      products = _json.map((final e) => ProductViewModel.fromJson(e)).toList();
      return Right(products);
    } on DioError catch (e) {
      return Left(e.response?.statusCode);
    }
  }
}
