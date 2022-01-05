import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../eshop.dart';
import '../../shared/models/person_dto.dart';
import '../../shared/models/person_view_model.dart';
import '../repositories/repositories_remember_password.dart';

class ControllerRememberPassword extends GetxController {
  final TextEditingController controllerUsername = TextEditingController();
  final TextEditingController controllerMobile = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();
  final TextEditingController controllerPasswordVerify =
      TextEditingController();
  final RepositoriesRememberPassword _repository =
      RepositoriesRememberPassword();
  List<PersonViewModel> persons = <PersonViewModel>[];
  late PersonDto person;
  int personId = 0;
  RxBool passwordFieldVsible = false.obs;

  Future<void> _getPersons() async {
    final _result = await _repository.getPersons();
    _result.fold((final l) {}, (final r) {
      persons = r;
    });
  }

  int checkUser() {
    int _result = 0;
    persons.forEach((final element) {
      if (element.username == controllerUsername.text &&
          element.mobile == controllerMobile.text) {
        personId = element.id;
        person = PersonDto(
            isadmin: element.isadmin,
            username: element.username,
            password: element.password,
            name: element.name,
            family: element.family,
            address: element.address,
            favorite: element.favorite,
            mobile: element.mobile,
            pic: element.pic);
        _result = 1;
      }
    });
    return _result;
  }

  Future<void> rememberPasswordClick() async {
    if (!passwordFieldVsible.value) {
      await _getPersons();
      final int _result = checkUser();
      if (_result == 0) {
        ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
            content:
                Text(LocaleKeys.eshop_business_exception_user_not_found.tr)));
      } else {
        passwordFieldVsible.value = true;
      }
    } else {
      if (controllerPassword.text != controllerPasswordVerify.text) {
        ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
            content:
                Text(LocaleKeys.eshop_business_exception_password_verify.tr)));
      } else {
        person.password = controllerPassword.text;
        final _resultt = await _repository.editPerson(personId, person);
        _resultt.fold((final l) {
          ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
              content: Text(LocaleKeys
                  .eshop_business_exception_change_password_error.tr)));
        }, (final r) {
          ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
              content: Text(LocaleKeys
                  .eshop_business_exception_change_password_successful.tr)));
          Get.back();
        });
      }
    }
  }
}
