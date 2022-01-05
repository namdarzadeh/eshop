import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../infrastructures/commons/repository_urls.dart';
import '../../shared/models/product_dto.dart';
import '../../shared/models/product_view_model.dart';

class RepositoriesProductListAdmin {
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

  Future<Either<int?, int>> putProduct(
      final int id, final ProductDto productDto) async {
    try {
      await RepositoryUrls.dioPut('${RepositoryUrls.fullBaseUrl}/product', id,
          ProductDto.toJson(productDto));
      return const Right(1);
    } on DioError catch (e) {
      return Left(e.response?.statusCode);
    }
  }

  Future<Either<int?, int>> deleteProduct(final int id) async {
    try {
      await RepositoryUrls.dioDelete(
          '${RepositoryUrls.fullBaseUrl}/product', id);
      return const Right(1);
    } on DioError catch (e) {
      return Left(e.response?.statusCode);
    }
  }
}
