import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

import '../../../../eshop.dart';

class CustomDrawerWidget extends StatelessWidget {
  const CustomDrawerWidget({
    final Key? key,
  }) : super(key: key);

  @override
  Widget build(final BuildContext context) => Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('تست'),
            ),
            drawerItem('تست 1', '${EShopRouteNames.login}'),
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
