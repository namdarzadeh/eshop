import 'package:dio/dio.dart';

import '../../../infrastructures/commons/repository_urls.dart';
import '../../shared/models/product_dto.dart';
import '../../shared/models/tag_view_model.dart';

class RepositoriesAddProduct {
  Future<int?> addProduct(final ProductDto productDto) async {
    final map = ProductDto.toJson(productDto);
    try {
      final Map<String, dynamic> _json = await RepositoryUrls.dioPost(
          '${RepositoryUrls.fullBaseUrl}/product', map);
      return _json['id'];
    } on DioError catch (e) {
      return e.response?.statusCode;
    }
  }

  Future<List<TagViewModel>> getTags() async {
    List<TagViewModel> tags = <TagViewModel>[];
    try {
      final List<dynamic> _json =
          await RepositoryUrls.dioGet('${RepositoryUrls.fullBaseUrl}/tags');
      tags = _json.map((final e) => TagViewModel.fromJson(e)).toList();
      return tags;
    } on DioError catch (e) {
      return tags;
    }
  }

  Future<int?> addTag(final String tag) async {
    final Map<String, dynamic> map = {'name': tag};
    try {
      final Map<String, dynamic> _json = await RepositoryUrls.dioPost(
          '${RepositoryUrls.fullBaseUrl}/tags', map);
      return _json['id'];
    } on DioError catch (e) {
      return e.response?.statusCode;
    }
  }
}
