import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../eshop.dart';
import '../../shared/models/person_view_model.dart';
import '../repositories/repositories_login.dart';

class ControllerLogin extends GetxController {
  final TextEditingController controllerUsername = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();
  final RepositoriesLogin _repository = RepositoriesLogin();
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

  int checkUser() {
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
    if (controllerUsername.text.trim().isEmpty ||
        controllerPassword.text.trim().isEmpty) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content:
              Text(LocaleKeys.eshop_business_exception_fill_all_field.tr)));
    } else {
      final int _result = await _getPerson();
      if (_result == 0) {
        ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
            content:
                Text(LocaleKeys.eshop_business_exception_http_error_500.tr)));
      } else {
        final int _checkUserResult = await checkUser();
        if (_checkUserResult == 0) {
          ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
              content: Text(LocaleKeys
                  .eshop_business_exception_infomation_incorrect.tr)));
        } else {
          EShopParameters.localPersonViewModel = personViewModel;
          if (personViewModel.isadmin == 1) {
            await Get.offNamed(EShopRouteNames.productListAdmin);
          } else {
            await Get.offNamed(EShopRouteNames.productListUser);
          }
        }
      }
    }
  }

  void registerClick() {
    Get.toNamed(EShopRouteNames.register);
  }
}
