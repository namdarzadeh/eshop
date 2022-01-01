import 'dart:convert';
import 'dart:io' as io;
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../eshop.dart';
import '../../shared/models/person_dto.dart';
import '../../shared/models/person_view_model.dart';
import '../repositories/repositories_register.dart';

class ControllerRegister extends GetxController {
  final TextEditingController controllerName = TextEditingController();
  final TextEditingController controllerFamily = TextEditingController();
  final TextEditingController controllerUsername = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();
  final TextEditingController controllerPasswordVerify =
      TextEditingController();
  final TextEditingController controllerAddress = TextEditingController();
  final RepositoriesRegister _repository = RepositoriesRegister();
  List<PersonViewModel> person = <PersonViewModel>[];
  late PersonViewModel personViewModel;
  String img64 = '';
  RxBool localPic = true.obs;
  late Uint8List imageBytes;
  final ImagePicker _picker = ImagePicker();

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
        favorite: '',
        mobile: '',
        pic: img64);
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
        controllerAddress.text.trim().isEmpty ||
        img64.isEmpty) {
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

  Future<String> imageToBase64(final XFile? _image) async {
    final bytes = await io.File(_image!.path).readAsBytes();
    imageBytes = bytes;
    final String _img64 = base64Encode(bytes);
    return _img64;
  }

  Future<void> imagePickerClick() async {
    final XFile? _image = await _picker.pickImage(source: ImageSource.gallery);
    img64 = await imageToBase64(_image);
    localPic.value = true;
    localPic.value = false;
  }
}
