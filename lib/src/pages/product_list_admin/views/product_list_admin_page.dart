import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../eshop.dart';
import '../../../infrastructures/utils/eshop_utils.dart';
import '../../shared/models/product_view_model.dart';
import '../../shared/views/custom_drawer_widget.dart';
import '../../shared/views/custom_filter_widget.dart';
import '../../shared/views/custom_padding_widget.dart';
import '../../shared/views/custom_switch_widget.dart';
import '../controllers/controller_product_list_admin.dart';

class ProductListAdminPage extends GetView<ControllerProductListAdmin> {
  const ProductListAdminPage({final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) => Scaffold(
        key: controller.scafoldKey,
        appBar: AppBar(
          title: Text(
              LocaleKeys.eshop_product_list_admin_page_product_list_admin.tr),
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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            controller.addProductClick();
          },
          backgroundColor: Colors.blueAccent,
          child: const Icon(Icons.add),
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
          final ProductViewModel product, final BuildContext context) =>
      Padding(
        padding: EdgeInsets.only(bottom: EShopUtils.largePadding()),
        child: Card(
          elevation: 3,
          shadowColor: Colors.blue[700],
          child: Padding(
            padding: EdgeInsets.all(EShopUtils.largePadding()),
            child: InkWell(
              onTap: () {
                controller.editProductClick(product.id);
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
                              padding:
                                  EdgeInsets.all(EShopUtils.smallPadding()),
                              child: Text(
                                  product.name.length > 5
                                      ? '  ${product.name.substring(0, 5)}..'
                                      : '  ${product.name}',
                                  style: TextStyle(
                                      fontSize: EShopUtils.largeTextSize())),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.all(EShopUtils.smallPadding()),
                              child: Row(
                                children: [
                                  Text('${product.price.toString()} '),
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
                      Row(
                        children: [
                          Text(LocaleKeys.eshop_shared_deactive.tr,
                              style: TextStyle(
                                  fontSize: EShopUtils.smallTextSize())),
                          CustomSwitchWidget(
                              sendCheckboxState: (final i) =>
                                  controller.editProduct(i, product),
                              isSwitched: product.isactive == 1 ? true : false),
                          Text(LocaleKeys.eshop_shared_active.tr,
                              style: TextStyle(
                                  fontSize: EShopUtils.smallTextSize()))
                        ],
                      ),
                      Visibility(
                        visible: product.instock == 0 ? false : true,
                        child: CustomPaddingWidget(
                          widget: Row(
                            children: [
                              Text('${LocaleKeys.eshop_shared_instock.tr} : '),
                              Text(product.instock.toString())
                            ],
                          ),
                        ),
                      ),
                      Visibility(
                        visible: product.instock != 0 ? false : true,
                        child: CustomPaddingWidget(
                          widget: Row(
                            children: [
                              Text(LocaleKeys.eshop_shared_outofstock.tr,
                                  style: const TextStyle(color: Colors.red)),
                            ],
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(EShopUtils.smallPadding()),
                            width: 70,
                            height: 35,
                            child: ElevatedButton(
                                onPressed: () {
                                  controller.editProductClick(product.id);
                                },
                                child: Text(LocaleKeys.eshop_shared_edit.tr,
                                    style: TextStyle(
                                        fontSize: EShopUtils.smallTextSize()))),
                          ),
                          Container(
                            padding: EdgeInsets.all(EShopUtils.smallPadding()),
                            width: 70,
                            height: 35,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.red),
                                onPressed: () {
                                  controller.deleteProductClick(product.id);
                                },
                                child: Text(LocaleKeys.eshop_shared_delete.tr,
                                    style: TextStyle(
                                        fontSize: EShopUtils.smallTextSize()))),
                          ),
                        ],
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
