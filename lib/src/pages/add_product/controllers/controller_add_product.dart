import 'dart:convert';
import 'dart:io' as io;
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../eshop.dart';
import '../../shared/models/product_dto.dart';
import '../../shared/models/tag_view_model.dart';
import '../repositories/repositories_add_product.dart';

class ControllerAddProduct extends GetxController {
  final TextEditingController controllerName = TextEditingController();
  final TextEditingController controllerPrice = TextEditingController();
  final TextEditingController controllerInstock = TextEditingController();
  final TextEditingController controllerDetails = TextEditingController();
  final TextEditingController controllerTag = TextEditingController();
  final RepositoriesAddProduct _repository = RepositoriesAddProduct();
  String img64 = '';
  RxList<TagViewModel> tags = <TagViewModel>[].obs;
  List<String> localTagsList = <String>[];
  RxString localTags = ''.obs;
  RxBool localPic = true.obs;
  late Uint8List imageBytes;
  RxBool productStatus = false.obs;
  final ImagePicker _picker = ImagePicker();

  Future<void> _addProduct() async {
    final ProductDto productDto = ProductDto(
        isactive: productStatus.value ? 1 : 0,
        name: controllerName.text,
        price: int.tryParse(controllerPrice.text) ?? 0,
        instock: int.tryParse(controllerInstock.text) ?? 0,
        pic: img64,
        details: controllerDetails.text,
        tag: localTags.value);
    final _result = await _repository.addProduct(productDto);
    _result.fold((final l) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content:
              Text(LocaleKeys.eshop_business_exception_add_product_error.tr)));
    }, (final r) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text(
              LocaleKeys.eshop_business_exception_add_product_successful.tr)));
      Get.back(result: 1);
    });
  }

  Future<void> _getTags() async {
    final _result = await _repository.getTags();
    _result.fold((final l) {}, (final r) {
      tags.value = r;
    });
  }

  void _creatLocalTagsList() {
    tags.forEach((final element) {
      localTagsList.add(element.name);
    });
  }

  int checkTag() {
    int _result = 0;
    tags.forEach((final element) {
      if (element.name == controllerTag.text) {
        _result = 1;
      }
    });
    return _result;
  }

  Future<void> _addtag(final String tag) async {
    final _result = await _repository.addTag(tag);
    _result.fold((final l) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text(LocaleKeys.eshop_business_exception_add_tag_error.tr)));
    }, (final r) {});
  }

  Future<void> addTagClick() async {
    if (controllerTag.text.trim().isEmpty) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content:
              Text(LocaleKeys.eshop_business_exception_fill_tag_field.tr)));
    } else {
      await _getTags();
      final int _result = await checkTag();
      if (_result == 0) {
        await _addtag(controllerTag.text);
      }
      localTags.value = '$localTags ${controllerTag.text}';
    }
  }

  Future<void> addProductClick() async {
    if (controllerName.text.trim().isEmpty ||
        controllerPrice.text.trim().isEmpty ||
        controllerInstock.text.trim().isEmpty ||
        controllerDetails.text.trim().isEmpty) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content:
              Text(LocaleKeys.eshop_business_exception_fill_all_field.tr)));
    } else {
      await _addProduct();
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

  @override
  void onInit() async {
    await _getTags();
    _creatLocalTagsList();
    super.onInit();
  }
}
