import 'package:eshop/src/pages/shared/views/custom_number_lable_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../eshop.dart';
import '../../../infrastructures/utils/eshop_utils.dart';
import '../../shared/views/custom_lable_widget.dart';
import '../../shared/views/custom_padding_widget.dart';
import '../controllers/controller_remember_password.dart';

class RememberPasswordPage extends GetView<ControllerRememberPassword> {
  const RememberPasswordPage({final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) => Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(LocaleKeys.eshop_login_page_remember_password.tr),
          actions: [
            IconButton(
                onPressed: Get.back,
                icon: const Icon(Icons.arrow_forward_outlined))
          ],
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(EShopUtils.allPagePadding()),
          child: Center(
              child: Obx(() => Column(
                    children: [
                      Visibility(
                        visible: !controller.passwordFieldVsible.value,
                        child: CustomLableWidget(
                            controller: controller.controllerUsername,
                            title: LocaleKeys.eshop_shared_username.tr),
                      ),
                      Visibility(
                        visible: !controller.passwordFieldVsible.value,
                        child: CustomNumberLableWidget(
                            controller: controller.controllerMobile,
                            title: LocaleKeys.eshop_shared_mobile.tr),
                      ),
                      Visibility(
                          visible: controller.passwordFieldVsible.value,
                          child: Padding(
                              padding: EdgeInsets.all(
                                  EShopUtils.lableWidgetPadding()),
                              child: TextField(
                                  obscureText: true,
                                  enableSuggestions: false,
                                  autocorrect: false,
                                  controller: controller.controllerPassword,
                                  decoration: InputDecoration(
                                    border: const OutlineInputBorder(),
                                    labelText:
                                        LocaleKeys.eshop_shared_password.tr,
                                  )))),
                      Visibility(
                          visible: controller.passwordFieldVsible.value,
                          child: Padding(
                              padding: EdgeInsets.all(
                                  EShopUtils.lableWidgetPadding()),
                              child: TextField(
                                  obscureText: true,
                                  enableSuggestions: false,
                                  autocorrect: false,
                                  controller:
                                      controller.controllerPasswordVerify,
                                  decoration: InputDecoration(
                                    border: const OutlineInputBorder(),
                                    labelText: LocaleKeys
                                        .eshop_shared_password_repetition.tr,
                                  )))),
                      CustomPaddingWidget(
                          widget: ElevatedButton(
                              onPressed: () {
                                controller.rememberPasswordClick();
                              },
                              child: Text(LocaleKeys.eshop_shared_confirm.tr))),
                    ],
                  ))),
        ),
      );
}
