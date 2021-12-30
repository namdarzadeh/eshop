import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:number_picker/views/number_picker_small_widget.dart';

import '../../../../eshop.dart';
import '../../../infrastructures/utils/eshop_utils.dart';
import '../../shared/models/product_view_model.dart';
import '../../shared/views/custom_drawer_widget.dart';
import '../../shared/views/custom_padding_widget.dart';
import '../controllers/controller_cart.dart';

class CartPage extends GetView<ControllerCart> {
  const CartPage({final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(LocaleKeys.eshop_cart_page_cart.tr),
          actions: [
            // Navigate to the Search Screen
            IconButton(
                onPressed: Get.back,
                icon: const Icon(Icons.arrow_forward_outlined))
          ],
        ),
        drawer: const CustomDrawerWidget(),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(EShopUtils.allPagePadding()),
          child: Center(
              child: Column(children: [
            Card(
              elevation: 3,
              shadowColor: Colors.blue[700],
              child: Padding(
                padding: EdgeInsets.all(EShopUtils.largePadding()),
                child: Obx(() => Column(children: [
                      Padding(
                        padding:
                            EdgeInsets.only(bottom: EShopUtils.largePadding()),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsets.all(EShopUtils.smallPadding()),
                                child: Text(LocaleKeys.eshop_shared_name.tr,
                                    style: TextStyle(
                                        fontSize: EShopUtils.smallTextSize())),
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.all(EShopUtils.smallPadding()),
                                child: Text(
                                    LocaleKeys.eshop_cart_page_unit_price.tr,
                                    style: TextStyle(
                                        fontSize: EShopUtils.smallTextSize())),
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.all(EShopUtils.smallPadding()),
                                child: Text(
                                    LocaleKeys.eshop_cart_page_number.tr,
                                    style: TextStyle(
                                        fontSize: EShopUtils.smallTextSize())),
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.all(EShopUtils.smallPadding()),
                                child: Text(
                                    LocaleKeys.eshop_cart_page_total_price.tr,
                                    style: TextStyle(
                                        fontSize: EShopUtils.smallTextSize())),
                              ),
                            ]),
                      ),
                      ...orderList(context),
                    ])),
              ),
            ),
            Card(
              color: Colors.green,
              elevation: 3,
              shadowColor: Colors.blue[700],
              child: Padding(
                padding: EdgeInsets.all(EShopUtils.largePadding()),
                child: Obx(() => Column(children: [
                      Padding(
                        padding:
                            EdgeInsets.only(bottom: EShopUtils.largePadding()),
                        child: Row(children: [
                          Padding(
                            padding: EdgeInsets.all(EShopUtils.smallPadding()),
                            child: Text(
                                '${LocaleKeys.eshop_cart_page_number.tr} '
                                '${controller.orders.length} '
                                '${LocaleKeys.eshop_cart_page_number_product_per.tr} '
                                '${LocaleKeys.eshop_cart_page_total_price.tr} 0 '
                                '${LocaleKeys.eshop_shared_toman.tr}',
                                style: TextStyle(
                                    fontSize: EShopUtils.mediumTextSize())),
                          ),
                        ]),
                      ),
                    ])),
              ),
            ),
            CustomPaddingWidget(
                widget: ElevatedButton(
                    onPressed: () {},
                    child: Text(LocaleKeys.eshop_cart_page_submit_order.tr))),
          ])),
        ),
      );

  List<Widget> orderList(final BuildContext context) {
    final List<Widget> products = [];
    for (var i in controller.orders.value) {
      products.add(buildRow(i, context));
    }
    return products;
  }

  Padding buildRow(
          final ProductViewModel product, final BuildContext context) =>
      Padding(
        padding: EdgeInsets.only(bottom: EShopUtils.largePadding()),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Padding(
            padding: EdgeInsets.all(EShopUtils.smallPadding()),
            child: Text(product.name,
                style: TextStyle(fontSize: EShopUtils.smallTextSize())),
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.all(EShopUtils.smallPadding()),
                child: Text(product.price.toString(),
                    style: TextStyle(fontSize: EShopUtils.smallTextSize())),
              ),
              Padding(
                padding: EdgeInsets.all(EShopUtils.smallPadding()),
                child: Text(LocaleKeys.eshop_shared_toman.tr,
                    style: TextStyle(fontSize: EShopUtils.smallTextSize())),
              ),
            ],
          ),
          NumberPickerSmallWidget(
              sendNumber: (final i) => print(i), number: controller.number),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.all(EShopUtils.smallPadding()),
                child: Text('product.name',
                    style: TextStyle(fontSize: EShopUtils.smallTextSize())),
              ),
              Padding(
                padding: EdgeInsets.all(EShopUtils.smallPadding()),
                child: Text(LocaleKeys.eshop_shared_toman.tr,
                    style: TextStyle(fontSize: EShopUtils.smallTextSize())),
              ),
            ],
          ),
        ]),
      );
}
