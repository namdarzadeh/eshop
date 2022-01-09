import 'package:eshop/src/pages/shared/views/custom_autocomplete_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../eshop.dart';
import '../../../infrastructures/utils/eshop_utils.dart';
import '../../shared/views/custom_drawer_widget.dart';
import '../../shared/views/custom_lable_widget.dart';
import '../../shared/views/custom_number_lable_widget.dart';
import '../../shared/views/custom_padding_widget.dart';
import '../../shared/views/custom_switch_widget.dart';
import '../controllers/controller_edit_product.dart';

class EditProductPage extends GetView<ControllerEditProduct> {
  const EditProductPage({final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) => Scaffold(
        appBar: AppBar(
            title: Text(LocaleKeys.eshop_edit_product_page_edit_product.tr)),
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
              CustomNumberLableWidget(
                  controller: controller.controllerPrice,
                  title: LocaleKeys.eshop_shared_product_price.tr),
              CustomNumberLableWidget(
                  controller: controller.controllerInstock,
                  title: LocaleKeys.eshop_shared_instock.tr),
              CustomLableWidget(
                  controller: controller.controllerDetails,
                  title: LocaleKeys.eshop_shared_details.tr),
              Padding(
                padding: EdgeInsets.fromLTRB(
                    EShopUtils.lableWidgetPadding(),
                    EShopUtils.mediumPadding(),
                    EShopUtils.lableWidgetPadding(),
                    EShopUtils.mediumPadding()),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(LocaleKeys.eshop_shared_product_status.tr),
                    Row(
                      children: [
                        Text(LocaleKeys.eshop_shared_deactive.tr),
                        Obx(() => CustomSwitchWidget(
                            sendCheckboxState: (final i) =>
                                controller.productStatus.value = i,
                            isSwitched: controller.productStatus.value)),
                        Text(LocaleKeys.eshop_shared_active.tr)
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  CustomAutocompleteWidget(
                      controller: controller.controllerTag,
                      tags: controller.localTagsList),
                  ElevatedButton(
                    onPressed: () {
                      controller.addTagClick();
                    },
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                    ),
                    child: const Icon(Icons.add),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                    EShopUtils.lableWidgetPadding(),
                    EShopUtils.mediumPadding(),
                    EShopUtils.lableWidgetPadding(),
                    EShopUtils.mediumPadding()),
                child: Row(
                  children: [
                    Card(
                        child: Padding(
                      padding: EdgeInsets.all(EShopUtils.largePadding()),
                      child: Obx(() => Text(controller.localTags.value)),
                    )),
                  ],
                ),
              ),
              CustomPaddingWidget(
                  widget: ElevatedButton(
                      onPressed: () {
                        controller.editProductClick();
                      },
                      child: Text(
                          LocaleKeys.eshop_edit_product_page_edit_product.tr))),
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
                Obx(() => ClipOval(
                      child: Container(
                          height: 100,
                          width: 100,
                          child: controller.localPic.value
                              ? Image.asset('lib/assets/icons/product.png',
                                  package: 'eshop', fit: BoxFit.cover)
                              : Image.memory(controller.imageBytes,
                                  fit: BoxFit.cover)),
                    )),
                Padding(
                  padding: EdgeInsets.only(top: EShopUtils.largePadding()),
                  child: Text(LocaleKeys.eshop_shared_select_picture.tr),
                )
              ],
            ),
          ),
        ),
      );
}
