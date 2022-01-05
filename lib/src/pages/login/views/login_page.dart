import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../eshop.dart';
import '../../../infrastructures/utils/eshop_utils.dart';
import '../../shared/views/custom_lable_widget.dart';
import '../../shared/views/custom_padding_widget.dart';
import '../controllers/controller_login.dart';

class LoginPage extends GetView<ControllerLogin> {
  const LoginPage({final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) => Scaffold(
        appBar: AppBar(title: Text(LocaleKeys.eshop_shared_online_shop.tr)),
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
              Padding(
                  padding: EdgeInsets.all(EShopUtils.lableWidgetPadding()),
                  child: Obx(() => TextField(
                      obscureText: controller.showPassword.value,
                      enableSuggestions: false,
                      autocorrect: false,
                      controller: controller.controllerPassword,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: LocaleKeys.eshop_shared_password.tr,
                        suffixIcon: IconButton(
                            icon: Icon(controller.showPassword.value
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () {
                              controller.showPassword.value =
                                  !controller.showPassword.value;
                            }),
                      )))),
              CustomPaddingWidget(
                  widget: ElevatedButton(
                      onPressed: () {
                        controller.loginClick();
                      },
                      child: Text(LocaleKeys.eshop_login_page_login.tr))),
              CustomPaddingWidget(
                  widget: InkWell(
                onTap: () {
                  Get.toNamed(EShopRouteNames.rememberPassword);
                },
                child: Text(LocaleKeys.eshop_login_page_remember_password.tr,
                    style: const TextStyle(color: Colors.blue)),
              )),
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
