import 'package:eshop/eshop.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LocalizationService extends Translations {
  Map<String, String> fa = {}, en = {};

  LocalizationService() {
    fa.addAll(Locales.fa_IR);
    en.addAll(Locales.en_US);
  }

  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys => {'fa': fa, 'en': en};
}

void main() async {
  runApp(const EShopApp());
}

class EShopApp extends StatelessWidget {
  const EShopApp({final Key? key}) : super(key: key);
  @override
  Widget build(final BuildContext context) {
    _setInitialUrlData();
    return GetMaterialApp(
      title: _materialTitle(),
      theme: CustomMaterialTheme(fontFamily: 'IRANSans').themeData,
      scrollBehavior: const CustomScrollBehavior(),
      debugShowCheckedModeBanner: false,
      //TODO call not found page
      // unknownRoute: GetPage(
      //   name: SalaryRouteNames.notFound,
      //   page: () => const NotFoundPage(),
      // ),
      getPages: [
        ...EShopParameters.pages,
      ],
      locale: const Locale('fa', 'IR'),
      translations: LocalizationService(),
      initialRoute: EShopRouteNames.splashScreen,
    );
  }

  void _setInitialUrlData() {
    EShopParameters.fullBaseUrl = 'http://192.168.7.111:3000';
  }

  String _materialTitle() => 'EShop Public Stage';
}
