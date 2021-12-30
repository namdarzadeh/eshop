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
        appBar: AppBar(
          title: Text(LocaleKeys.eshop_product_list_user_page_product_list.tr),
          actions: [
            // Navigate to the Search Screen
            IconButton(
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (final _) => const SearchPage())),
                icon: const Icon(Icons.search)),
            IconButton(
                onPressed: () => Get.toNamed(EShopRouteNames.cart),
                icon: const Icon(Icons.shopping_cart_rounded)),
          ],
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
                              child: Image.asset(
                                  'lib/assets/icons/download.jpg',
                                  package: 'eshop')),
                          Column(children: [
                            Padding(
                              padding:
                                  EdgeInsets.all(EShopUtils.smallPadding()),
                              child: Text(product.name,
                                  style: TextStyle(
                                      fontSize: EShopUtils.largeTextSize())),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.all(EShopUtils.smallPadding()),
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
                          sendNumber: (final i) => print(i),
                          number: controller.number)
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
