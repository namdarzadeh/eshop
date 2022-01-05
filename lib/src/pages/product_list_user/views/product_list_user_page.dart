import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:number_picker/views/number_picker_widget.dart';

import '../../../../eshop.dart';
import '../../../infrastructures/utils/eshop_utils.dart';
import '../../shared/models/product_view_model.dart';
import '../../shared/views/custom_drawer_widget.dart';
import '../../shared/views/custom_filter_widget.dart';
import '../../shared/views/custom_padding_widget.dart';
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
                onPressed: () => controller.cartClick(),
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
          if (EShopParameters.filterResult[3] == true) {
            if (i.instock > 5) {
              products.add(buildCard(i, context));
            }
          } else if (EShopParameters.filterResult[2] == true) {
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
    final RxInt _number = controller.getnumber(product).obs;
    final bool _inStock = product.instock == 0 ? false : true;
    return Padding(
      padding: EdgeInsets.only(bottom: EShopUtils.largePadding()),
      child: Card(
        elevation: 3,
        shadowColor: Colors.blue[700],
        child: Padding(
          padding: EdgeInsets.all(EShopUtils.largePadding()),
          child: InkWell(
            onTap: () {
              controller.showProductClick(product);
            },
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
                              child: Image.memory(
                                  controller.base64ToByte(product.pic),
                                  fit: BoxFit.cover)),
                        ),
                        Column(children: [
                          Padding(
                            padding: EdgeInsets.all(EShopUtils.smallPadding()),
                            child: Text(
                                product.name.length > 12
                                    ? '  ${product.name.substring(0, 12)} ...'
                                    : '  ${product.name}',
                                style: TextStyle(
                                    fontSize: EShopUtils.largeTextSize())),
                          ),
                          Padding(
                            padding: EdgeInsets.all(EShopUtils.smallPadding()),
                            child: Row(
                              children: [
                                Text('  ${product.price.toString()} '),
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
                          Text('${LocaleKeys.eshop_shared_details.tr} : '),
                          Text(product.details.length > 15
                              ? '${product.details.substring(0, 15)} ...'
                              : product.details)
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(EShopUtils.smallPadding()),
                      child: Row(
                        children: [
                          Text('${LocaleKeys.eshop_shared_tag.tr} : '),
                          Text(product.tag.length > 15
                              ? '${product.tag.substring(0, 15)} ...'
                              : product.tag)
                        ],
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Card(
                      elevation: 2,
                      child: Padding(
                        padding: EdgeInsets.all(EShopUtils.largePadding()),
                        child: InkWell(
                          onTap: () {
                            controller.favoritClick(product.id);
                          },
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.only(
                                    bottom: EShopUtils.largePadding()),
                                height: 50,
                                width: 50,
                                child: controller.checkUserFavorit(product)
                                    ? const Icon(Icons.favorite)
                                    : const Icon(Icons.favorite_outline),
                              ),
                              Text(LocaleKeys.eshop_shared_favorit.tr,
                                  style: TextStyle(
                                      fontSize: EShopUtils.smallTextSize()))
                            ],
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: _inStock,
                      child: NumberPickerWidget(
                        sendNumber: (final i) {
                          if (controller.checkInstock(product, i) == 1) {
                            _number.value = i;
                            controller.updateCart(product, _number.value);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(LocaleKeys
                                    .eshop_business_exception_maximum_unit_added
                                    .tr)));
                          }
                        },
                        number: _number.value,
                        size: EShopUtils.largePadding(),
                      ),
                    ),
                    Visibility(
                      visible: !_inStock,
                      child: CustomPaddingWidget(
                        widget: Row(
                          children: [
                            Text(LocaleKeys.eshop_shared_outofstock.tr,
                                style: const TextStyle(color: Colors.red)),
                          ],
                        ),
                      ),
                    ),
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
