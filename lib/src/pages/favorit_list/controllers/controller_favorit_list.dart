import 'package:get/get.dart';

import '../../../../eshop.dart';
import '../../shared/models/product_view_model.dart';
import '../repositories/repositories_favorit_list.dart';

class ControllerFavoritList extends GetxController {
  final RepositoriesFavoritList _repository = RepositoriesFavoritList();
  RxList<ProductViewModel> products = <ProductViewModel>[].obs;
  RxList<String> userFavorit = <String>[].obs;

  Future<void> _getProducts() async {
    final _result = await _repository.getProducts();
    _result.fold((final l) {}, (final r) {
      products.value = r;
    });
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

  @override
  void onInit() async {
    await _getProducts();
    getUserFavorit();
    super.onInit();
  }
}
