import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../eshop.dart';
import '../../shared/models/person_view_model.dart';
import '../repositories/repositories_login_page.dart';

class ControllerLoginPage extends GetxController {
  final TextEditingController controllerUsername = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();
  final RepositoriesLoginPage _repository = RepositoriesLoginPage();
  List<PersonViewModel> person = <PersonViewModel>[];
  late PersonViewModel personViewModel;

  Future<int> _getPerson() async {
    person = await _repository.getPerson();
    if (person.isEmpty) {
      return 0;
    } else {
      return 1;
    }
  }

  Future<int> checkUser() async {
    int _result = 0;
    person.forEach((final element) {
      if (element.username == controllerUsername.text &&
          element.password == controllerPassword.text) {
        _result = 1;
        personViewModel = element;
      }
    });
    return _result;
  }

  Future<void> loginClick() async {
    final int _result = await _getPerson();
    if (_result == 0) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(
          content: Text(LocaleKeys.eshop_shared_error,
              textDirection: TextDirection.rtl)));
    } else {
      final int _checkUserResult = await checkUser();
      if (_checkUserResult == 0) {
        ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(
            content: Text(LocaleKeys.eshop_shared_error,
                textDirection: TextDirection.rtl)));
      } else {
        // into product page
      }
    }
  }

  void registerClick() {
    // into register page
  }
}
