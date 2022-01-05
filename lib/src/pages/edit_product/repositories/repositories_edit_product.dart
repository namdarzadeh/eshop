import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../infrastructures/commons/repository_urls.dart';
import '../../shared/models/product_dto.dart';
import '../../shared/models/product_view_model.dart';
import '../../shared/models/tag_view_model.dart';

class RepositoriesEditProduct {
  Future<Either<int?, ProductViewModel>> getProduct(final int id) async {
    ProductViewModel product = ProductViewModel(
        id: 0,
        isactive: 0,
        name: '',
        price: 0,
        instock: 0,
        pic: '',
        details: '',
        tag: '');
    try {
      final Map<String, dynamic> _json = await RepositoryUrls.dioGet(
          '${RepositoryUrls.fullBaseUrl}/product/$id');
      product = ProductViewModel.fromJson(_json);
      return Right(product);
    } on DioError catch (e) {
      return Left(e.response?.statusCode);
    }
  }

  Future<Either<int?, int>> editProduct(
      final int id, final ProductDto productDto) async {
    try {
      await RepositoryUrls.dioPut('${RepositoryUrls.fullBaseUrl}/product', id,
          ProductDto.toJson(productDto));
      return const Right(1);
    } on DioError catch (e) {
      return Left(e.response?.statusCode);
    }
  }

  Future<Either<int?, List<TagViewModel>>> getTags() async {
    List<TagViewModel> tags = <TagViewModel>[];
    try {
      final List<dynamic> _json =
          await RepositoryUrls.dioGet('${RepositoryUrls.fullBaseUrl}/tags');
      tags = _json.map((final e) => TagViewModel.fromJson(e)).toList();
      return Right(tags);
    } on DioError catch (e) {
      return Left(e.response?.statusCode);
    }
  }

  Future<Either<int?, int>> addTag(final String tag) async {
    final Map<String, dynamic> map = {'name': tag};
    try {
      final Map<String, dynamic> _json = await RepositoryUrls.dioPost(
          '${RepositoryUrls.fullBaseUrl}/tags', map);
      return Right(_json['id']);
    } on DioError catch (e) {
      return Left(e.response?.statusCode);
    }
  }
}
