import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../infrastructures/commons/repository_urls.dart';
import '../../shared/models/person_dto.dart';
import '../../shared/models/product_view_model.dart';

class RepositoriesProductListUser {
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

  Future<Either<int?, int>> editPerson(
      final int id, final PersonDto personDto) async {
    try {
      await RepositoryUrls.dioPut('${RepositoryUrls.fullBaseUrl}/person', id,
          PersonDto.toJson(personDto));
      return const Right(1);
    } on DioError catch (e) {
      return Left(e.response?.statusCode);
    }
  }

  Future<Either<int?, int>> editSetting(
      final int id, final PersonDto personDto) async {
    try {
      await RepositoryUrls.dioPut('${RepositoryUrls.fullBaseUrl}/setting', id,
          PersonDto.toJson(personDto));
      return const Right(1);
    } on DioError catch (e) {
      return Left(e.response?.statusCode);
    }
  }
}
