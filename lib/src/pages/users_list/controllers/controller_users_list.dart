import 'package:get/get.dart';

import '../../shared/models/person_dto.dart';
import '../../shared/models/person_view_model.dart';
import '../repositories/repositories_users_list.dart';

class ControllerUsersList extends GetxController {
  final RepositoriesUsersList _repository = RepositoriesUsersList();
  RxList<PersonViewModel> persons = <PersonViewModel>[].obs;

  Future<void> _getPersons() async {
    final _result = await _repository.getPersons();
    _result.fold((final l) {}, (final r) {
      persons.value = r;
    });
  }

  Future<void> editPerson(final bool i, final PersonViewModel person) async {
    if (i) {
      final PersonDto _person = PersonDto(
          isadmin: 1,
          username: person.username,
          password: person.password,
          name: person.name,
          family: person.family,
          address: person.address,
          favorite: person.favorite,
          mobile: person.mobile,
          pic: person.pic);
      await _repository.editPerson(person.id, _person);
    } else {
      final PersonDto _person = PersonDto(
          isadmin: 0,
          username: person.username,
          password: person.password,
          name: person.name,
          family: person.family,
          address: person.address,
          favorite: person.favorite,
          mobile: person.mobile,
          pic: person.pic);
      await _repository.editPerson(person.id, _person);
      await _repository.editSetting(person.id, _person);
    }
    await _getPersons();
  }

  @override
  void onInit() async {
    await _getPersons();
    super.onInit();
  }
}
