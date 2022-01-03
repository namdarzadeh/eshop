import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../infrastructures/commons/repository_urls.dart';
import '../../shared/models/product_dto.dart';
import '../../shared/models/tag_view_model.dart';

class RepositoriesAddProduct {
  Future<Either<int?, int>> addProduct(final ProductDto productDto) async {
    final map = ProductDto.toJson(productDto);
    try {
      final Map<String, dynamic> _json = await RepositoryUrls.dioPost(
          '${RepositoryUrls.fullBaseUrl}/product', map);
      return Right(_json['id']);
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
