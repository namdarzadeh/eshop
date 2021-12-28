import 'package:dio/dio.dart';

import '../../../infrastructures/commons/repository_urls.dart';
import '../../shared/models/person_dto.dart';
import '../../shared/models/person_view_model.dart';

class RepositoriesRegister {
  Future<List<PersonViewModel>> getPerson() async {
    List<PersonViewModel> person = <PersonViewModel>[];
    try {
      final List<dynamic> _json =
          await RepositoryUrls.dioGet('${RepositoryUrls.fullBaseUrl}/person');
      person = _json.map((final e) => PersonViewModel.fromJson(e)).toList();
      return person;
    } on DioError catch (e) {
      return person;
    }
  }

  Future<int?> addPerson(final PersonDto personDto) async {
    final map = PersonDto.toJson(personDto);
    try {
      final Map<String, dynamic> _json = await RepositoryUrls.dioPost(
          '${RepositoryUrls.fullBaseUrl}/person', map);
      return _json['id'];
    } on DioError catch (e) {
      return e.response?.statusCode;
    }
  }
}
