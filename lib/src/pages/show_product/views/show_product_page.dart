import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:number_picker/views/number_picker_widget.dart';

import '../../../../eshop.dart';
import '../../../infrastructures/utils/eshop_utils.dart';
import '../../shared/views/custom_drawer_widget.dart';
import '../controllers/controller_show_product.dart';

class ShowProductPage extends GetView<ControllerShowProduct> {
  const ShowProductPage({final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Obx(() => Text(
              '${LocaleKeys.eshop_shared_id.tr} ${controller.product.value.id}')),
          actions: [
            IconButton(
                onPressed: () => controller.cartClick(),
                icon: const Icon(Icons.shopping_cart_rounded)),
            IconButton(
                onPressed: Get.back,
                icon: const Icon(Icons.arrow_forward_outlined)),
          ],
        ),
        drawer: const CustomDrawerWidget(),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(EShopUtils.allPagePadding()),
          child: Center(
              child: Column(children: [
            Padding(
              padding: EdgeInsets.only(bottom: EShopUtils.largePadding()),
              child: Obx(() => Card(
                    elevation: 3,
                    shadowColor: Colors.blue[700],
                    child: Padding(
                      padding: EdgeInsets.all(EShopUtils.largePadding()),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  ClipOval(
                                    child: Container(
                                        height: 100,
                                        width: 100,
                                        child: controller.localPic.value
                                            ? Image.asset(
                                                'lib/assets/icons/product.png',
                                                package: 'eshop',
                                                fit: BoxFit.cover)
                                            : Image.memory(
                                                controller.imageBytes,
                                                fit: BoxFit.cover)),
                                  ),
                                  Column(children: [
                                    Padding(
                                      padding: EdgeInsets.all(
                                          EShopUtils.smallPadding()),
                                      child: Text(
                                          '  ${controller.product.value.name}',
                                          style: TextStyle(
                                              fontSize:
                                                  EShopUtils.largeTextSize())),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(
                                          EShopUtils.smallPadding()),
                                      child: Row(
                                        children: [
                                          Text(
                                              '  ${controller.product.value.price} '
                                                  .toString()),
                                          Text(LocaleKeys.eshop_shared_toman.tr)
                                        ],
                                      ),
                                    )
                                  ])
                                ],
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.all(EShopUtils.smallPadding()),
                                child: Row(
                                  children: [
                                    Text(
                                        '${LocaleKeys.eshop_shared_details.tr} : '),
                                    Text(controller.product.value.details)
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.all(EShopUtils.smallPadding()),
                                child: Row(
                                  children: [
                                    Text(
                                        '${LocaleKeys.eshop_shared_tag.tr} : '),
                                    Text(controller.product.value.tag)
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Card(
                                child: Padding(
                                  padding:
                                      EdgeInsets.all(EShopUtils.largePadding()),
                                  child: InkWell(
                                    onTap: () {},
                                    child: Column(
                                      children: [
                                        Container(
                                            padding: EdgeInsets.only(
                                                bottom:
                                                    EShopUtils.largePadding()),
                                            height: 50,
                                            width: 50,
                                            child: const Icon(Icons.favorite)),
                                        Text(LocaleKeys.eshop_shared_favorit.tr,
                                            style: TextStyle(
                                                fontSize:
                                                    EShopUtils.smallTextSize()))
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              NumberPickerWidget(
                                  sendNumber: (final i) {
                                    controller.number.value = i;
                                    controller.updateCart(
                                        controller.product.value,
                                        controller.number.value);
                                  },
                                  number: controller.number,
                                  size: EShopUtils.largePadding())
                            ],
                          ),
                        ],
                      ),
                    ),
                  )),
            ),
          ])),
        ),
      );
}
