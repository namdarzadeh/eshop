import 'package:dio/dio.dart';

import '../../../eshop.dart';

class RepositoryUrls {
  bool forDisableWarning() => true;

  static String fullBaseUrl = EShopParameters.fullBaseUrl;

  static Future<dynamic> dioGet(final String url) async {
    final Dio dio = Dio();
    final Response response = await dio.get(url);
    return response.data;
  }

  static Future<dynamic> dioPost(
      final String url, final Map<String, dynamic> map) async {
    final Dio dio = Dio();
    final Response response = await dio.post(url, data: map);
    return response.data;
  }

  static Future<dynamic> dioPut(
      final String url, final int id, final Map<String, dynamic> map) async {
    final Dio dio = Dio();
    final Response response = await dio.put('$url/$id', data: map);
    return response.data;
  }

  static Future<dynamic> dioDelete(final String url, final int id) async {
    final Dio dio = Dio();
    final Response response = await dio.delete('$url/$id');
    return response.data;
  }
}
