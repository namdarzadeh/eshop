import 'package:dio/dio.dart';
import 'package:eshop/src/pages/shared/models/person_dto.dart';

import '../../../infrastructures/commons/repository_urls.dart';
import '../../shared/models/person_view_model.dart';

class RepositoriesRememberPassword {
  Future<List<PersonViewModel>> getPersons() async {
    List<PersonViewModel> persons = <PersonViewModel>[];
    try {
      final List<dynamic> _json =
          await RepositoryUrls.dioGet('${RepositoryUrls.fullBaseUrl}/person');
      persons = _json.map((final e) => PersonViewModel.fromJson(e)).toList();
      return persons;
    } on DioError catch (e) {
      return persons;
    }
  }

  Future<int> editPerson(final int id, final PersonDto personDto) async {
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
