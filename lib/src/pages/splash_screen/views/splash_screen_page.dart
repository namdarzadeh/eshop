import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../eshop.dart';
import '../../../infrastructures/utils/eshop_utils.dart';
import '../controllers/controller_splash_screen.dart';

class SplashScreenPage extends StatelessWidget {
  const SplashScreenPage({final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) {
    Get.put(ControllerSplashScreen());
    return Scaffold(
      body: Center(
          child: Padding(
        padding: EdgeInsets.all(EShopUtils.splashScreenPadding()),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                padding: EdgeInsets.all(EShopUtils.splashScreenPadding()),
                height: 200,
                width: 200,
                child: Image.asset('lib/assets/icons/shops.png',
                    package: 'eshop')),
            Padding(
              padding: EdgeInsets.all(EShopUtils.splashScreenPadding()),
              child: Text(LocaleKeys.eshop_shared_online_shop.tr),
            ),
            Padding(
              padding: EdgeInsets.all(EShopUtils.splashScreenPadding()),
              child: const CircularProgressIndicator(),
            ),
            Container(
                alignment: Alignment.bottomCenter,
                height: 100,
                width: 100,
                child: Text(LocaleKeys.eshop_shared_app_version.tr)),
          ],
        ),
      )),
    );
  }
}
