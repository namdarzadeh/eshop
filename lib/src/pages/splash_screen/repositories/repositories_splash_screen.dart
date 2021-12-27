import 'package:dio/dio.dart';
import 'package:eshop/src/infrastructures/commons/repository_urls.dart';
import 'package:eshop/src/pages/shared/models/person_dto.dart';
import 'package:eshop/src/pages/shared/models/person_view_model.dart';

class RepositoriesSplashScreen {
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

  Future<int?> setupAdmin() async {
    final map = PersonDto.toJson(PersonDto(
        isadmin: 1,
        username: 'admin',
        password: '123456',
        name: 'مدیریت',
        family: 'فروشگاه',
        address: 'شیراز',
        favorite: ''));
    try {
      final Map<String, dynamic> _json = await RepositoryUrls.dioPost(
          '${RepositoryUrls.fullBaseUrl}/person', map);
      return _json['id'];
    } on DioError catch (e) {
      return e.response?.statusCode;
    }
  }
}
