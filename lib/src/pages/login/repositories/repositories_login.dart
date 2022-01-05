import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../infrastructures/commons/repository_urls.dart';
import '../../shared/models/person_view_model.dart';

class RepositoriesLogin {
  Future<Either<int?, List<PersonViewModel>>> getPersons() async {
    List<PersonViewModel> persons = <PersonViewModel>[];
    try {
      final List<dynamic> _json =
          await RepositoryUrls.dioGet('${RepositoryUrls.fullBaseUrl}/person');
      persons = _json.map((final e) => PersonViewModel.fromJson(e)).toList();
      return Right(persons);
    } on DioError catch (e) {
      return Left(e.response?.statusCode);
    }
  }

  Future<Either<int?, int>> addSetting(
      final PersonViewModel personViewModel) async {
    final Map<String, dynamic> map = {
      'id': personViewModel.id,
      'isadmin': personViewModel.isadmin,
      'username': personViewModel.username,
      'password': personViewModel.password,
      'name': personViewModel.name,
      'family': personViewModel.family,
      'address': personViewModel.address,
      'favorite': personViewModel.favorite,
      'mobile': personViewModel.mobile,
      'pic': personViewModel.pic,
    };
    try {
      final Map<String, dynamic> _json = await RepositoryUrls.dioPost(
          '${RepositoryUrls.fullBaseUrl}/setting', map);
      return Right(_json['id']);
    } on DioError catch (e) {
      return Left(e.response?.statusCode);
    }
  }
}
