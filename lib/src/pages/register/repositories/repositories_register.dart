import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../infrastructures/commons/repository_urls.dart';
import '../../shared/models/person_dto.dart';
import '../../shared/models/person_view_model.dart';

class RepositoriesRegister {
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

  Future<Either<int?, int>> addPerson(final PersonDto personDto) async {
    final map = PersonDto.toJson(personDto);
    try {
      final Map<String, dynamic> _json = await RepositoryUrls.dioPost(
          '${RepositoryUrls.fullBaseUrl}/person', map);
      return Right(_json['id']);
    } on DioError catch (e) {
      return Left(e.response?.statusCode);
    }
  }
}
