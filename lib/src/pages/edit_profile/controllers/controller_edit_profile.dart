import 'dart:convert';
import 'dart:io' as io;
import 'dart:typed_data';

import 'package:eshop/src/pages/shared/models/person_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../eshop.dart';
import '../../shared/models/person_dto.dart';
import '../repositories/repositories_edit_profile.dart';

class ControllerEditProfile extends GetxController {
  final TextEditingController controllerName = TextEditingController();
  final TextEditingController controllerFamily = TextEditingController();
  final TextEditingController controllerUsername = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();
  final TextEditingController controllerPasswordVerify =
      TextEditingController();
  final TextEditingController controllerAddress = TextEditingController();
  final TextEditingController controllerMobile = TextEditingController();
  final RepositoriesEditProfile _repository = RepositoriesEditProfile();
  String img64 = EShopParameters.localPersonViewModel.pic;
  late Uint8List imageBytes;
  RxBool localPic = true.obs;
  final ImagePicker _picker = ImagePicker();

  Future<void> _editProfile() async {
    final PersonDto person = PersonDto(
        isadmin: EShopParameters.localPersonViewModel.isadmin,
        username: controllerUsername.text,
        password: controllerPassword.text,
        name: controllerName.text,
        family: controllerFamily.text,
        address: controllerAddress.text,
        favorite: EShopParameters.localPersonViewModel.favorite,
        mobile: controllerMobile.text,
        pic: img64);
    final int? _result = await _repository.editPerson(
        EShopParameters.localPersonViewModel.id, person);
    if (_result == 0) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content:
              Text(LocaleKeys.eshop_business_exception_edit_product_error.tr)));
    } else {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text(
              LocaleKeys.eshop_business_exception_edit_product_successful.tr)));
      setLocalPerson();
      Get.back();
    }
  }

  Future<void> editProfileClick() async {
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
      await _editProfile();
    }
  }

  Uint8List base64ToByte(final String pic) {
    final decodedBytes = base64Decode(pic);
    return decodedBytes;
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

  void setProfile() async {
    controllerName.text = EShopParameters.localPersonViewModel.name;
    controllerFamily.text = EShopParameters.localPersonViewModel.family;
    controllerUsername.text = EShopParameters.localPersonViewModel.username;
    controllerPassword.text = EShopParameters.localPersonViewModel.password;
    controllerPasswordVerify.text =
        EShopParameters.localPersonViewModel.password;
    controllerAddress.text = EShopParameters.localPersonViewModel.address;
    controllerMobile.text = EShopParameters.localPersonViewModel.mobile;
    imageBytes = base64ToByte(EShopParameters.localPersonViewModel.pic);
    localPic.value = false;
  }

  void setLocalPerson() async {
    EShopParameters.localPersonViewModel = PersonViewModel(
        id: EShopParameters.localPersonViewModel.id,
        isadmin: EShopParameters.localPersonViewModel.isadmin,
        username: controllerUsername.text,
        password: controllerPassword.text,
        name: controllerName.text,
        family: controllerFamily.text,
        address: controllerAddress.text,
        favorite: EShopParameters.localPersonViewModel.favorite,
        mobile: controllerMobile.text,
        pic: img64);
  }

  @override
  void onInit() {
    setProfile();
    super.onInit();
  }
}
