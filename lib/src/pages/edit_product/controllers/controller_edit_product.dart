import 'dart:convert';
import 'dart:io' as io;
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../eshop.dart';
import '../../shared/models/product_dto.dart';
import '../../shared/models/product_view_model.dart';
import '../../shared/models/tag_view_model.dart';
import '../repositories/repositories_edit_product.dart';

class ControllerEditProduct extends GetxController {
  final TextEditingController controllerName = TextEditingController();
  final TextEditingController controllerPrice = TextEditingController();
  final TextEditingController controllerInstock = TextEditingController();
  final TextEditingController controllerDetails = TextEditingController();
  final TextEditingController controllerTag = TextEditingController();
  final RepositoriesEditProduct _repository = RepositoriesEditProduct();
  RxList<TagViewModel> tags = <TagViewModel>[].obs;
  RxBool localPic = true.obs;
  late Uint8List imageBytes;
  ProductViewModel product = ProductViewModel(
      id: 0,
      isactive: 0,
      name: '',
      price: 0,
      instock: 0,
      pic: '',
      details: '',
      tag: '');
  RxString localTags = ''.obs;
  RxBool productStatus = false.obs;
  final ImagePicker _picker = ImagePicker();
  String img64 = '';

  Future<int> _getProduct(final int id) async {
    product = await _repository.getProduct(id);
    return 1;
  }

  void setProduct() async {
    product.isactive == 1
        ? productStatus.value = true
        : productStatus.value = false;
    controllerName.text = product.name;
    controllerPrice.text = product.price.toString();
    controllerInstock.text = product.instock.toString();
    controllerDetails.text = product.details;
    localTags.value = product.tag;
    await Future.delayed(const Duration(milliseconds: 2000));
    imageBytes = base64ToByte(product.pic);
    img64 = product.pic;
    localPic.value = false;
  }

  Future<void> _editProduct() async {
    final ProductDto productDto = ProductDto(
        isactive: productStatus.value ? 1 : 0,
        name: controllerName.text,
        price: int.tryParse(controllerPrice.text) ?? 0,
        instock: int.tryParse(controllerInstock.text) ?? 0,
        pic: img64,
        details: controllerDetails.text,
        tag: localTags.value);
    final int? _result = await _repository.editProduct(product.id, productDto);
    if (_result == 0) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content:
              Text(LocaleKeys.eshop_business_exception_edit_product_error.tr)));
    } else {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text(
              LocaleKeys.eshop_business_exception_edit_product_successful.tr)));
      Get.back(result: 1);
    }
  }

  Future<int> _getTags() async {
    tags.value = await _repository.getTags();
    return 1;
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
    final int? _result = await _repository.addTag(tag);
    if (_result == 0) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text(LocaleKeys.eshop_business_exception_add_tag_error.tr)));
    }
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
      localTags.value = '$localTags #${controllerTag.text}';
    }
  }

  Future<void> editProductClick() async {
    if (controllerName.text.trim().isEmpty ||
        controllerPrice.text.trim().isEmpty ||
        controllerInstock.text.trim().isEmpty ||
        controllerDetails.text.trim().isEmpty) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content:
              Text(LocaleKeys.eshop_business_exception_fill_all_field.tr)));
    } else {
      await _editProduct();
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

  @override
  void onInit() async {
    await _getProduct(Get.arguments as int);
    setProduct();
    super.onInit();
  }
}
