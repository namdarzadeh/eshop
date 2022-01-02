import 'package:eshop/src/pages/shared/views/custom_filter_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:number_picker/views/number_picker_widget.dart';

import '../../../../eshop.dart';
import '../../../infrastructures/utils/eshop_utils.dart';
import '../../shared/models/product_view_model.dart';
import '../../shared/views/custom_drawer_widget.dart';
import '../controllers/controller_product_list_user.dart';

class ProductListUserPage extends GetView<ControllerProductListUser> {
  const ProductListUserPage({final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) => Scaffold(
        key: controller.scafoldKey,
        appBar: AppBar(
          title: Text(LocaleKeys.eshop_product_list_user_page_product_list.tr),
          actions: [
            Obx(() => Visibility(
                  visible: !controller.searchMode.value,
                  child: IconButton(
                      onPressed: () {
                        controller.searchClick();
                      },
                      icon: const Icon(Icons.search)),
                )),
            Obx(() => Visibility(
                  visible: controller.searchMode.value,
                  child: IconButton(
                      onPressed: () {
                        controller.clearSearchClick();
                      },
                      icon: const Icon(Icons.clear)),
                )),
            IconButton(
                onPressed: () => Get.toNamed(EShopRouteNames.cart),
                icon: const Icon(Icons.shopping_cart_rounded)),
            Obx(() => Visibility(
                  visible: !EShopParameters.filterMode.value,
                  child: IconButton(
                      onPressed: () {
                        controller.scafoldKey.currentState?.openEndDrawer();
                      },
                      icon: const Icon(Icons.filter_list_rounded)),
                )),
            Obx(() => Visibility(
                  visible: EShopParameters.filterMode.value,
                  child: IconButton(
                      onPressed: () {
                        controller.clearFilterClick();
                      },
                      icon: const Icon(Icons.clear)),
                )),
          ],
        ),
        drawer: const CustomDrawerWidget(),
        endDrawer: CustomFilterWidget(),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(EShopUtils.allPagePadding()),
          child: Center(
              child: Column(children: [
            Obx(() => Column(children: [
                  ...productList(context),
                ]))
          ])),
        ),
      );

  List<Widget> productList(final BuildContext context) {
    final List<Widget> products = [];
    for (var i in controller.products.value) {
      if (EShopParameters.filterMode.value) {
        if (i.price >= EShopParameters.filterResult[0] &&
            i.price <= EShopParameters.filterResult[1]) {
          if (EShopParameters.filterResult[2] == true) {
            if (i.instock > 0) {
              products.add(buildCard(i, context));
            }
          } else {
            products.add(buildCard(i, context));
          }
        }
      } else {
        products.add(buildCard(i, context));
      }
    }
    return products;
  }

  Padding buildCard(
      final ProductViewModel product, final BuildContext context) {
    final RxInt _number = 0.obs;
    return Padding(
      padding: EdgeInsets.only(bottom: EShopUtils.largePadding()),
      child: Card(
        elevation: 3,
        shadowColor: Colors.blue[700],
        child: Padding(
          padding: EdgeInsets.all(EShopUtils.largePadding()),
          child: InkWell(
            onTap: () {
              Get.toNamed(EShopRouteNames.showProduct, arguments: product);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        Container(
                            padding: EdgeInsets.fromLTRB(
                                0, 0, EShopUtils.largelistPadding(), 0),
                            height: 100,
                            width: 100,
                            child: Image.memory(
                                controller.base64ToByte(product.pic))),
                        Column(children: [
                          Padding(
                            padding: EdgeInsets.all(EShopUtils.smallPadding()),
                            child: Text(product.name,
                                style: TextStyle(
                                    fontSize: EShopUtils.largeTextSize())),
                          ),
                          Padding(
                            padding: EdgeInsets.all(EShopUtils.smallPadding()),
                            child: Row(
                              children: [
                                Text(product.price.toString()),
                                Text(LocaleKeys.eshop_shared_toman.tr)
                              ],
                            ),
                          )
                        ])
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.all(EShopUtils.smallPadding()),
                      child: Row(
                        children: [
                          Text(LocaleKeys.eshop_shared_details.tr),
                          Text(product.details)
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(EShopUtils.smallPadding()),
                      child: Row(
                        children: [
                          Text(LocaleKeys.eshop_shared_tag.tr),
                          Text(product.tag)
                        ],
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Card(
                      child: Padding(
                        padding: EdgeInsets.all(EShopUtils.largePadding()),
                        child: InkWell(
                          onTap: () {},
                          child: Column(
                            children: [
                              Container(
                                  padding: EdgeInsets.only(
                                      bottom: EShopUtils.largePadding()),
                                  height: 30,
                                  width: 30,
                                  child: Image.asset(
                                      'lib/assets/icons/icfav.png',
                                      package: 'eshop')),
                              Text(LocaleKeys.eshop_shared_favorit.tr,
                                  style: TextStyle(
                                      fontSize: EShopUtils.smallTextSize()))
                            ],
                          ),
                        ),
                      ),
                    ),
                    NumberPickerWidget(
                        sendNumber: (final i) {
                          _number.value = i;
                          controller.addToCart(product, _number.value);
                        },
                        number: _number)
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
