import 'package:eshop/src/infrastructures/utils/eshop_utils.dart';
import 'package:eshop/src/pages/shared/views/custom_padding_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../../../../eshop.dart';
import 'custom_switch_widget.dart';

class CustomFilterWidget extends StatelessWidget {
  TextEditingController controllerFrom = TextEditingController();
  TextEditingController controllerUntil = TextEditingController();
  RxBool isSwitched = false.obs;
  CustomFilterWidget({
    final Key? key,
  }) : super(key: key);
  @override
  Widget build(final BuildContext context) => Drawer(
        child: ListView(
          padding: EdgeInsets.fromLTRB(
              EShopUtils.largePadding(),
              EShopUtils.filterTopPadding(),
              EShopUtils.largePadding(),
              EShopUtils.largePadding()),
          children: [
            CustomPaddingWidget(
                widget: Text(LocaleKeys.eshop_shared_price_renge.tr)),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(LocaleKeys.eshop_shared_from.tr),
              Container(
                padding: EdgeInsets.all(EShopUtils.lableWidgetPadding()),
                height: 60,
                width: 110,
                child: TextField(
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  controller: controllerFrom,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: LocaleKeys.eshop_shared_price.tr,
                  ),
                ),
              ),
              Text(LocaleKeys.eshop_shared_until.tr),
              Container(
                padding: EdgeInsets.all(EShopUtils.lableWidgetPadding()),
                height: 60,
                width: 110,
                child: TextField(
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  controller: controllerUntil,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: LocaleKeys.eshop_shared_price.tr,
                  ),
                ),
              ),
              Text(LocaleKeys.eshop_shared_toman.tr),
            ]),
            CustomPaddingWidget(
              widget: Container(
                color: Colors.black,
                height: 1,
              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              Text(LocaleKeys.eshop_shared_only_available_product.tr),
              Obx(() => CustomSwitchWidget(
                  sendCheckboxState: (final i) {
                    isSwitched.value = i;
                  },
                  isSwitched: isSwitched.value)),
            ]),
            Padding(
              padding: const EdgeInsets.fromLTRB(80, 100, 80, 0),
              child: ElevatedButton(
                  onPressed: () {
                    EShopParameters.filterResult[0] =
                        int.tryParse(controllerFrom.text) ?? 0;
                    EShopParameters.filterResult[1] =
                        int.tryParse(controllerUntil.text) ?? 1000000000;
                    EShopParameters.filterResult[2] = isSwitched;
                    EShopParameters.filterMode.value = true;
                    Get.back();
                  },
                  child: Text(LocaleKeys.eshop_shared_filter_done.tr)),
            ),
          ],
        ),
      );
}
