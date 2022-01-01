import 'package:eshop/src/pages/remember_password/repositories/repositories_remember_password.dart';
import 'package:eshop/src/pages/shared/models/person_dto.dart';
import 'package:eshop/src/pages/shared/models/person_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../eshop.dart';

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
    persons = await _repository.getPersons();
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
        final int _resultt = await _repository.editPerson(personId, person);
        if (_resultt == 1) {
          ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
              content: Text(LocaleKeys
                  .eshop_business_exception_change_password_successful.tr)));
          Get.back();
        }
      }
    }
  }
}
