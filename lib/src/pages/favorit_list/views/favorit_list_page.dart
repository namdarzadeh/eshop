import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../eshop.dart';
import '../../../infrastructures/utils/eshop_utils.dart';
import '../../shared/models/product_view_model.dart';
import '../../shared/views/custom_drawer_widget.dart';
import '../controllers/controller_favorit_list.dart';

class FavoritListPage extends GetView<ControllerFavoritList> {
  const FavoritListPage({final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(LocaleKeys.eshop_shared_favorit_list.tr),
          actions: [
            IconButton(
                onPressed: Get.back,
                icon: const Icon(Icons.arrow_forward_outlined))
          ],
        ),
        drawer: const CustomDrawerWidget(),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(EShopUtils.allPagePadding()),
          child: Center(
              child: Obx(() => Column(children: [
                    Card(
                      elevation: 3,
                      shadowColor: Colors.blue[700],
                      child: Padding(
                        padding: EdgeInsets.all(EShopUtils.largePadding()),
                        child: Column(children: [
                          Padding(
                            padding: EdgeInsets.only(
                                bottom: EShopUtils.largePadding()),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(
                                        EShopUtils.smallPadding()),
                                    child: Text(LocaleKeys.eshop_shared_id.tr,
                                        style: TextStyle(
                                            fontSize:
                                                EShopUtils.smallTextSize())),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(
                                        EShopUtils.smallPadding()),
                                    child: Text(
                                        LocaleKeys.eshop_shared_product_name.tr,
                                        style: TextStyle(
                                            fontSize:
                                                EShopUtils.smallTextSize())),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(
                                        EShopUtils.smallPadding()),
                                    child: Text(
                                        LocaleKeys
                                            .eshop_shared_product_price.tr,
                                        style: TextStyle(
                                            fontSize:
                                                EShopUtils.smallTextSize())),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(
                                        EShopUtils.smallPadding()),
                                    child: Text(
                                        LocaleKeys.eshop_shared_instock.tr,
                                        style: TextStyle(
                                            fontSize:
                                                EShopUtils.smallTextSize())),
                                  ),
                                ]),
                          ),
                          ...favoritsList(context),
                        ]),
                      ),
                    ),
                  ]))),
        ),
      );

  List<Widget> favoritsList(final BuildContext context) {
    final List<Widget> favorits = [];
    for (var i in controller.products.value) {
      if (controller.checkUserFavorit(i)) {
        favorits.add(buildRow(i, context));
      }
    }
    return favorits;
  }

  Padding buildRow(
          final ProductViewModel product, final BuildContext context) =>
      Padding(
        padding: EdgeInsets.only(bottom: EShopUtils.largePadding()),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Padding(
            padding: EdgeInsets.all(EShopUtils.smallPadding()),
            child: Text(product.id.toString(),
                style: TextStyle(fontSize: EShopUtils.smallTextSize())),
          ),
          Padding(
            padding: EdgeInsets.all(EShopUtils.smallPadding()),
            child: Text(product.name,
                style: TextStyle(fontSize: EShopUtils.smallTextSize())),
          ),
          Padding(
            padding: EdgeInsets.all(EShopUtils.smallPadding()),
            child: Text(product.price.toString(),
                style: TextStyle(fontSize: EShopUtils.smallTextSize())),
          ),
          Padding(
            padding: EdgeInsets.all(EShopUtils.smallPadding()),
            child: Text(
                product.instock.toString() == 0
                    ? LocaleKeys.eshop_shared_outofstock.tr
                    : LocaleKeys.eshop_shared_instock_status.tr,
                style: TextStyle(fontSize: EShopUtils.smallTextSize())),
          ),
        ]),
      );
}
