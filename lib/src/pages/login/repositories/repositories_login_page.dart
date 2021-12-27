import 'package:dio/dio.dart';
import 'package:eshop/src/infrastructures/commons/repository_urls.dart';
import 'package:eshop/src/pages/shared/models/person_view_model.dart';

class RepositoriesLoginPage {
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
}
