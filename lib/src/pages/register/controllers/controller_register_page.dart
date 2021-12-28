import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../eshop.dart';
import '../../shared/models/person_dto.dart';
import '../../shared/models/person_view_model.dart';
import '../repositories/repositories_register_page.dart';

class ControllerRegisterPage extends GetxController {
  final TextEditingController controllerName = TextEditingController();
  final TextEditingController controllerFamily = TextEditingController();
  final TextEditingController controllerUsername = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();
  final TextEditingController controllerPasswordVerify =
      TextEditingController();
  final TextEditingController controllerAddress = TextEditingController();
  final RepositoriesRegisterPage _repository = RepositoriesRegisterPage();
  List<PersonViewModel> person = <PersonViewModel>[];
  late PersonViewModel personViewModel;

  Future<void> _getPerson() async {
    person = await _repository.getPerson();
  }

  int checkUser() {
    int _result = 0;
    person.forEach((final element) {
      if (element.username == controllerUsername.text) {
        _result = 1;
      }
    });
    return _result;
  }

  Future<void> _addPerson() async {
    final PersonDto personDto = PersonDto(
        isadmin: 0,
        username: controllerUsername.text,
        password: controllerPassword.text,
        name: controllerName.text,
        family: controllerFamily.text,
        address: controllerAddress.text,
        favorite: '');
    final int? _result = await _repository.addPerson(personDto);
    if (_result == 0) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content:
              Text(LocaleKeys.eshop_business_exception_register_error.tr)));
    } else {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text(
              LocaleKeys.eshop_business_exception_register_successful.tr)));
      await Get.offNamed(EShopRouteNames.login);
    }
  }

  Future<void> registerClick() async {
    if (controllerName.text.trim().isEmpty ||
        controllerFamily.text.trim().isEmpty ||
        controllerUsername.text.trim().isEmpty ||
        controllerPassword.text.trim().isEmpty ||
        controllerPasswordVerify.text.trim().isEmpty ||
        controllerAddress.text.trim().isEmpty) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content:
              Text(LocaleKeys.eshop_business_exception_fill_all_field.tr)));
    } else if (controllerPassword.text != controllerPasswordVerify.text) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content:
              Text(LocaleKeys.eshop_business_exception_password_verify.tr)));
    } else {
      await _getPerson();
      final int _checkUserResult = checkUser();
      if (_checkUserResult == 1) {
        ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
            content: Text(
                LocaleKeys.eshop_business_exception_repetitious_username.tr)));
      } else {
        await _addPerson();
      }
    }
  }
}
