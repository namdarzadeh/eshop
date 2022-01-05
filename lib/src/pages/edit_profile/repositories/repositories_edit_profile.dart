import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:eshop/src/infrastructures/commons/repository_urls.dart';
import 'package:eshop/src/pages/shared/models/person_dto.dart';

class RepositoriesEditProfile {
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
