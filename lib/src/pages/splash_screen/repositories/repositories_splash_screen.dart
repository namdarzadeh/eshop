import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../infrastructures/commons/repository_urls.dart';
import '../../shared/models/person_dto.dart';
import '../../shared/models/person_view_model.dart';

class RepositoriesSplashScreen {
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

  Future<Either<int?, int>> setupAdmin() async {
    final map = PersonDto.toJson(PersonDto(
        isadmin: 1,
        username: 'admin',
        password: '123456',
        name: 'مدیریت',
        family: 'فروشگاه',
        address: 'شیراز',
        favorite: '',
        mobile: '',
        pic:
            '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'));
    try {
      final Map<String, dynamic> _json = await RepositoryUrls.dioPost(
          '${RepositoryUrls.fullBaseUrl}/person', map);
      return Right(_json['id']);
    } on DioError catch (e) {
      return Left(e.response?.statusCode);
    }
  }

  Future<Either<int?, List<PersonViewModel>>> getSetting() async {
    List<PersonViewModel> setting = <PersonViewModel>[];
    try {
      final List<dynamic> _json =
          await RepositoryUrls.dioGet('${RepositoryUrls.fullBaseUrl}/setting');
      setting = _json.map((final e) => PersonViewModel.fromJson(e)).toList();
      return Right(setting);
    } on DioError catch (e) {
      return Left(e.response?.statusCode);
    }
  }
}
