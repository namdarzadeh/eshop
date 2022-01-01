import 'package:dio/dio.dart';
import 'package:eshop/src/infrastructures/commons/repository_urls.dart';
import 'package:eshop/src/pages/shared/models/person_dto.dart';

class RepositoriesEditProfile {
  Future<int?> editPerson(final int id, final PersonDto personDto) async {
    try {
      final _json = await RepositoryUrls.dioPut(
          '${RepositoryUrls.fullBaseUrl}/person',
          id,
          PersonDto.toJson(personDto));
      return 1;
    } on DioError catch (e) {
      return 0;
    }
  }
}
