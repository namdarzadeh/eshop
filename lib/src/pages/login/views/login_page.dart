import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../eshop.dart';
import '../../../infrastructures/utils/eshop_utils.dart';
import '../../shared/views/custom_drawer_widget.dart';
import '../../shared/views/custom_lable_widget.dart';
import '../../shared/views/custom_padding_widget.dart';
import '../controllers/controller_login_page.dart';

class LoginPage extends GetView<ControllerLoginPage> {
  const LoginPage({final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) => Scaffold(
        appBar: AppBar(title: Text(LocaleKeys.eshop_shared_online_shop.tr)),
        drawer: const CustomDrawerWidget(),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(EShopUtils.allPagePadding()),
          child: Center(
              child: Column(
            children: [
              CustomPaddingWidget(
                  widget: Text(LocaleKeys.eshop_login_page_singup_later.tr)),
              CustomLableWidget(
                  controller: controller.controllerUsername,
                  title: LocaleKeys.eshop_shared_username.tr),
              CustomLableWidget(
                  controller: controller.controllerPassword,
                  title: LocaleKeys.eshop_shared_password.tr),
              CustomPaddingWidget(
                  widget: ElevatedButton(
                      onPressed: () {
                        controller.loginClick();
                      },
                      child: Text(LocaleKeys.eshop_login_page_login.tr))),
              CustomPaddingWidget(
                  widget: Text(LocaleKeys.eshop_login_page_new_register.tr)),
              CustomPaddingWidget(
                  widget: ElevatedButton(
                      onPressed: () {
                        controller.registerClick();
                      },
                      child: Text(LocaleKeys.eshop_shared_register.tr))),
            ],
          )),
        ),
      );
}
