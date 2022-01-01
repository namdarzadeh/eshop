import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../eshop.dart';
import '../../../infrastructures/utils/eshop_utils.dart';
import '../../shared/views/custom_lable_widget.dart';
import '../../shared/views/custom_padding_widget.dart';
import '../controllers/controller_register.dart';

class RegisterPage extends GetView<ControllerRegister> {
  const RegisterPage({final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) => Scaffold(
        appBar: AppBar(title: Text(LocaleKeys.eshop_shared_register.tr)),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(EShopUtils.allPagePadding()),
          child: Center(
              child: Column(
            children: [
              imagePickerCard(),
              CustomLableWidget(
                  controller: controller.controllerName,
                  title: LocaleKeys.eshop_shared_name.tr),
              CustomLableWidget(
                  controller: controller.controllerFamily,
                  title: LocaleKeys.eshop_shared_family.tr),
              CustomLableWidget(
                  controller: controller.controllerUsername,
                  title: LocaleKeys.eshop_shared_username.tr),
              Padding(
                  padding: EdgeInsets.all(EShopUtils.lableWidgetPadding()),
                  child: TextField(
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                      controller: controller.controllerPassword,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: LocaleKeys.eshop_shared_password.tr,
                      ))),
              Padding(
                  padding: EdgeInsets.all(EShopUtils.lableWidgetPadding()),
                  child: TextField(
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                      controller: controller.controllerPasswordVerify,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText:
                            LocaleKeys.eshop_shared_password_repetition.tr,
                      ))),
              CustomLableWidget(
                  controller: controller.controllerAddress,
                  title: LocaleKeys.eshop_shared_address.tr),
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

  Card imagePickerCard() => Card(
        child: Padding(
          padding: EdgeInsets.all(EShopUtils.allPagePadding()),
          child: InkWell(
            onTap: () {
              controller.imagePickerClick();
            },
            child: Column(
              children: [
                Obx(() => Container(
                    padding: EdgeInsets.only(bottom: EShopUtils.largePadding()),
                    height: 100,
                    width: 100,
                    child: controller.localPic.value
                        ? Image.asset('lib/assets/icons/profile.png',
                            package: 'eshop')
                        : Image.memory(controller.imageBytes))),
                Text(LocaleKeys.eshop_shared_select_picture.tr)
              ],
            ),
          ),
        ),
      );
}
