import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../eshop.dart';
import '../../shared/models/person_dto.dart';
import '../../shared/models/person_view_model.dart';
import '../../shared/models/product_view_model.dart';
import '../repositories/repositories_product_list_user.dart';

class ControllerProductListUser extends GetxController {
  GlobalKey<ScaffoldState> scafoldKey = GlobalKey<ScaffoldState>();
  final RepositoriesProductListUser _repository = RepositoriesProductListUser();
  RxList<ProductViewModel> products = <ProductViewModel>[].obs;
  RxBool searchMode = false.obs;
  RxList<String> userFavorit = <String>[].obs;

  Future<int> _getProducts() async {
    int _localResult = 0;
    final _result = await _repository.getProducts();
    _result.fold((final l) {
      _localResult = 0;
    }, (final r) {
      products.value = r;
      _localResult = 1;
    });
    return _localResult;
  }

  Uint8List base64ToByte(final String pic) {
    final decodedBytes = base64Decode(pic);
    return decodedBytes;
  }

  Future<void> searchClick() async {
    final List<ProductViewModel> backProducts =
        await Get.toNamed(EShopRouteNames.search);
    if (backProducts.isNotEmpty) {
      products.value = backProducts;
      searchMode.value = true;
    }
  }

  Future<void> clearSearchClick() async {
    await _getProducts();
    searchMode.value = false;
  }

  Future<void> clearFilterClick() async {
    await _getProducts();
    EShopParameters.filterResult = [false, 0, 1000000000, false];
    EShopParameters.filterMode.value = false;
  }

  int getnumber(final ProductViewModel product) {
    int _result = 0;
    EShopParameters.orders.forEach((final element) {
      if (element[0] == product.name) {
        _result = element[2];
      }
    });
    return _result;
  }

  int checkInstock(final ProductViewModel product, final int number) {
    int _result = 0;
    if (product.instock >= number) {
      _result = 1;
    }
    return _result;
  }

  void updateCart(final ProductViewModel product, final int number) {
    int _result = 0;
    EShopParameters.orders.forEach((final element) {
      if (element[0] == product.name) {
        element[2] = number;
        _result = 1;
      }
    });
    if (_result == 0) {
      EShopParameters.orders.add([product.name, product.price, number]);
    }
  }

  Future<void> cartClick() async {
    await Get.toNamed(EShopRouteNames.cart);
    await _getProducts();
  }

  Future<void> showProductClick(final ProductViewModel product) async {
    await Get.toNamed(EShopRouteNames.showProduct, arguments: product);
    getUserFavorit();
    await _getProducts();
  }

  void getUserFavorit() {
    if (EShopParameters.localPersonViewModel.favorite.trim().isNotEmpty) {
      userFavorit.value =
          EShopParameters.localPersonViewModel.favorite.substring(1).split(' ');
    }
  }

  bool checkUserFavorit(final ProductViewModel _product) {
    bool _result = false;
    for (String fav in userFavorit) {
      if (_product.id.toString() == fav) {
        _result = true;
      }
    }
    return _result;
  }

  Future<void> editPerson(
      final List<dynamic> userFav, final PersonViewModel person) async {
    String _localFav = '';
    for (String fav in userFav) {
      _localFav = '$_localFav $fav';
    }
    final PersonDto _person = PersonDto(
        isadmin: person.isadmin,
        username: person.username,
        password: person.password,
        name: person.name,
        family: person.family,
        address: person.address,
        favorite: _localFav,
        mobile: person.mobile,
        pic: person.pic);
    await _repository.editPerson(person.id, _person);
    await _repository.editSetting(person.id, _person);
    EShopParameters.localPersonViewModel.favorite = _localFav;
  }

  Future<void> favoritClick(final int id) async {
    final String _localId = '$id';
    int addOrRemove = 1;
    if (userFavorit.isNotEmpty) {
      for (String fav in userFavorit) {
        if (fav == id.toString()) {
          addOrRemove = 0;
        }
      }
    }
    addOrRemove == 0 ? userFavorit.remove(_localId) : userFavorit.add(_localId);
    await editPerson(userFavorit, EShopParameters.localPersonViewModel);
  }

  @override
  void onInit() async {
    await _getProducts();
    getUserFavorit();
    super.onInit();
  }
}
