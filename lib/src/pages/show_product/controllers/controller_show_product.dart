import 'dart:convert';
import 'dart:typed_data';

import 'package:get/get.dart';

import '../../../../eshop.dart';
import '../../shared/models/person_dto.dart';
import '../../shared/models/person_view_model.dart';
import '../../shared/models/product_view_model.dart';
import '../repositories/repositories_show_product.dart';

class ControllerShowProduct extends GetxController {
  final RepositoriesShowProduct _repository = RepositoriesShowProduct();
  Rx<ProductViewModel> product = ProductViewModel(
          id: 0,
          isactive: 0,
          name: '',
          price: 0,
          instock: 0,
          pic: '',
          details: '',
          tag: '')
      .obs;
  RxInt number = 0.obs;
  RxBool localPic = true.obs;
  late Uint8List imageBytes;
  RxList<String> userFavorit = <String>[].obs;

  Uint8List base64ToByte(final String pic) {
    final decodedBytes = base64Decode(pic);
    return decodedBytes;
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
    number.value = getnumber(product.value);
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
    product.value = await Get.arguments as ProductViewModel;
    imageBytes = base64ToByte(product.value.pic);
    localPic.value = false;
    number.value = getnumber(product.value);
    getUserFavorit();
    super.onInit();
  }
}
