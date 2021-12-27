import 'package:get/get.dart';

import '../../../../eshop.dart';
import '../../shared/models/person_view_model.dart';
import '../repositories/repositories_splash_screen.dart';

class ControllerSplashScreen extends GetxController {
  final RepositoriesSplashScreen _repository = RepositoriesSplashScreen();
  List<PersonViewModel> person = <PersonViewModel>[];
  String onlineShop = LocaleKeys.eshop_shared_online_shop.tr;
  Future<int> _getPerson() async {
    person = await _repository.getPerson();
    return 1;
  }

  Future<void> firstUse() async {
    final int? result = await _repository.setupAdmin();
  }

  @override
  void onInit() async {
    await _getPerson();
    if (person.isEmpty) {
      await firstUse();
    }
    await Future.delayed(const Duration(milliseconds: 3000));
    await Get.offNamed(EShopRouteNames.login);
    super.onInit();
  }
}
