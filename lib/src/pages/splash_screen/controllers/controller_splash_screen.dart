import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../eshop.dart';
import '../../shared/models/person_view_model.dart';
import '../repositories/repositories_splash_screen.dart';

class ControllerSplashScreen extends GetxController {
  final RepositoriesSplashScreen _repository = RepositoriesSplashScreen();
  List<PersonViewModel> person = <PersonViewModel>[];
  List<PersonViewModel> setting = <PersonViewModel>[];

  Future<void> _getPerson() async {
    final _result = await _repository.getPersons();
    _result.fold((final l) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content:
              Text(LocaleKeys.eshop_business_exception_http_error_500.tr)));
    }, (final r) {
      person = r;
    });
  }

  Future<void> _getSetting() async {
    final _result = await _repository.getSetting();
    _result.fold((final l) {}, (final r) {
      setting = r;
    });
  }

  Future<void> checkLogin() async {
    await _getSetting();
    if (setting.isNotEmpty) {
      for (var i in setting) {
        EShopParameters.localPersonViewModel = i;
        if (i.isadmin == 1) {
          await Get.offNamed(EShopRouteNames.productListAdmin);
        } else {
          await Get.offNamed(EShopRouteNames.productListUser);
        }
      }
    } else {
      await Get.offNamed(EShopRouteNames.login);
    }
  }

  Future<void> firstUse() async {
    final _result = await _repository.setupAdmin();
    _result.fold((final l) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content:
              Text(LocaleKeys.eshop_business_exception_http_error_500.tr)));
    }, (final r) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text(
              LocaleKeys.eshop_business_exception_create_admin_successful.tr)));
    });
  }

  @override
  void onInit() async {
    await _getPerson();
    if (person.isEmpty) {
      await firstUse();
    }
    await Future.delayed(const Duration(milliseconds: 3000));
    await checkLogin();
    super.onInit();
  }
}
