import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../../../../eshop.dart';
import '../../../infrastructures/utils/eshop_utils.dart';

class CustomDrawerWidget extends StatelessWidget {
  const CustomDrawerWidget({
    final Key? key,
  }) : super(key: key);

  @override
  Widget build(final BuildContext context) => Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
              child: Center(
                  child: Column(
                children: [
                  ClipOval(
                    child: Container(
                        height: 100,
                        width: 100,
                        child: Image.memory(
                            base64Decode(
                                EShopParameters.localPersonViewModel.pic),
                            fit: BoxFit.cover)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: EShopUtils.largePadding()),
                    child: Text(
                        '${EShopParameters.localPersonViewModel.name} ${EShopParameters.localPersonViewModel.family}'),
                  ),
                ],
              )),
            ),
            drawerItem(LocaleKeys.eshop_edit_profile_page_edit_profile.tr,
                EShopRouteNames.editProfile),
            Visibility(
                visible: EShopParameters.localPersonViewModel.isadmin == 0
                    ? true
                    : false,
                child: drawerItem(
                    LocaleKeys.eshop_cart_page_cart.tr, EShopRouteNames.cart)),
            Visibility(
                visible: EShopParameters.localPersonViewModel.isadmin == 1
                    ? true
                    : false,
                child: drawerItem(
                    LocaleKeys
                        .eshop_product_list_admin_page_product_list_admin.tr,
                    EShopRouteNames.productListAdmin)),
            Visibility(
                visible: EShopParameters.localPersonViewModel.isadmin == 1
                    ? true
                    : false,
                child: drawerItem(
                    LocaleKeys.eshop_add_product_page_add_product.tr,
                    EShopRouteNames.addProduct)),
            Padding(
              padding: const EdgeInsets.fromLTRB(80, 100, 80, 0),
              child: ElevatedButton(
                  onPressed: () {
                    if (EShopParameters.defaultLanguage == 'fa') {
                      const locale = Locale('en', 'US');
                      Get.updateLocale(locale);
                      EShopParameters.defaultLanguage = 'en';
                    } else {
                      const locale = Locale('fa', 'IR');
                      Get.updateLocale(locale);
                      EShopParameters.defaultLanguage = 'fa';
                    }
                  },
                  child: Text(LocaleKeys.eshop_shared_change_language.tr)),
            ),
          ],
        ),
      );

  ListTile drawerItem(final String title, final String routeName) => ListTile(
        title: Text(title),
        onTap: () {
          Get.back();
          Get.toNamed(routeName);
        },
      );
}
