import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
  RxList<TagViewModel> tags = <TagViewModel>[].obs;
  RxString localTags = ''.obs;
  RxBool productStatus = false.obs;

  Future<void> _addProduct() async {
    final ProductDto productDto = ProductDto(
        isactive: productStatus.value ? 1 : 0,
        name: controllerName.text,
        price: int.tryParse(controllerPrice.text) ?? 0,
        instock: int.tryParse(controllerInstock.text) ?? 0,
        pic: 'pic',
        details: controllerDetails.text,
        tag: localTags.value);
    final int? _result = await _repository.addProduct(productDto);
    if (_result == 0) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content:
              Text(LocaleKeys.eshop_business_exception_add_product_error.tr)));
    } else {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text(
              LocaleKeys.eshop_business_exception_add_product_successful.tr)));
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

  Future<void> addProductClick() async {
    if (controllerName.text.trim().isEmpty ||
        controllerPrice.text.trim().isEmpty ||
        controllerInstock.text.trim().isEmpty ||
        controllerDetails.text.trim().isEmpty ||
        controllerTag.text.trim().isEmpty) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content:
              Text(LocaleKeys.eshop_business_exception_fill_all_field.tr)));
    } else {
      await _addProduct();
    }
  }
}
