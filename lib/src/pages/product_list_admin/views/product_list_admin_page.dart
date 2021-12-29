import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../eshop.dart';
import '../../../infrastructures/utils/eshop_utils.dart';
import '../../shared/models/product_view_model.dart';
import '../../shared/views/custom_drawer_widget.dart';
import '../../shared/views/custom_switch_widget.dart';
import '../controllers/controller_product_list_admin.dart';

class ProductListAdminPage extends GetView<ControllerProductListAdmin> {
  const ProductListAdminPage({final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(LocaleKeys.eshop_product_list_admin_page_shop_admin.tr),
          actions: [
            // Navigate to the Search Screen
            IconButton(
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (final _) => const SearchPage())),
                icon: const Icon(Icons.search))
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
      products.add(buildCard(i, context));
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
              onTap: () {},
              child: Row(
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          Container(
                              height: 100,
                              width: 100,
                              child: Image.asset(
                                  'lib/assets/icons/download.jpg',
                                  package: 'eshop')),
                          Column(children: [
                            Text(product.name),
                            Row(
                              children: [
                                Text(product.price.toString()),
                                Text(LocaleKeys.eshop_shared_toman.tr)
                              ],
                            )
                          ])
                        ],
                      ),
                      Row(
                        children: [
                          Text(LocaleKeys.eshop_shared_details.tr),
                          Text(product.details)
                        ],
                      ),
                      Row(
                        children: [
                          Text(LocaleKeys.eshop_shared_tag.tr),
                          Text(product.tag)
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          Text(LocaleKeys.eshop_shared_deactive.tr),
                          CustomSwitchWidget(
                              sendCheckboxState: (final i) =>
                                  controller.editProduct(i, product),
                              isSwitched: product.isactive == 1 ? true : false),
                          Text(LocaleKeys.eshop_shared_active.tr)
                        ],
                      ),
                      Row(
                        children: [
                          Text(LocaleKeys.eshop_shared_instock.tr),
                          Text(product.instock.toString())
                        ],
                      ),
                      Row(
                        children: [
                          ElevatedButton(
                              onPressed: () {},
                              child: Text(LocaleKeys.eshop_shared_edit.tr)),
                          ElevatedButton(
                              onPressed: () {
                                controller.deleteProductClick(product.id);
                              },
                              child: Text(LocaleKeys.eshop_shared_delete.tr)),
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

class SearchPage extends StatelessWidget {
  const SearchPage({final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) => Scaffold(
        appBar: AppBar(
            // The search area here
            title: Container(
          width: double.infinity,
          height: 40,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(5)),
          child: Center(
            child: TextField(
              decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {},
                  ),
                  hintText: LocaleKeys.eshop_shared_search.tr,
                  border: InputBorder.none),
            ),
          ),
        )),
      );
}
