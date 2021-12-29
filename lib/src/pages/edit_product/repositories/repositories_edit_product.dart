import 'package:dio/dio.dart';

import '../../../infrastructures/commons/repository_urls.dart';
import '../../shared/models/product_dto.dart';
import '../../shared/models/product_view_model.dart';
import '../../shared/models/tag_view_model.dart';

class RepositoriesEditProduct {
  Future<ProductViewModel> getProduct(final int id) async {
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
      return product;
    } on DioError catch (e) {
      return product;
    }
  }

  Future<int?> editProduct(final int id, final ProductDto productDto) async {
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
