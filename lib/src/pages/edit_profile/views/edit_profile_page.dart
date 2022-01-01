import 'package:eshop/src/infrastructures/utils/eshop_utils.dart';
import 'package:eshop/src/pages/shared/views/custom_drawer_widget.dart';
import 'package:eshop/src/pages/shared/views/custom_lable_widget.dart';
import 'package:eshop/src/pages/shared/views/custom_padding_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../eshop.dart';
import '../controllers/controller_edit_profile.dart';

class EditProfilePage extends GetView<ControllerEditProfile> {
  const EditProfilePage({final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) => Scaffold(
        appBar: AppBar(
            title: Text(LocaleKeys.eshop_edit_profile_page_edit_profile.tr)),
        drawer: const CustomDrawerWidget(),
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
              CustomLableWidget(
                  controller: controller.controllerMobile,
                  title: LocaleKeys.eshop_shared_mobile.tr),
              CustomPaddingWidget(
                  widget: ElevatedButton(
                      onPressed: () {
                        controller.editProfileClick();
                      },
                      child: Text(
                          LocaleKeys.eshop_edit_profile_page_edit_profile.tr))),
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
