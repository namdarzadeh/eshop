import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../eshop.dart';
import '../controllers/controller_search.dart';

class SearchPage extends GetView<ControllerSearch> {
  const SearchPage({final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) => Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Container(
            width: double.infinity,
            height: 40,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(5)),
            child: Center(
              child: TextField(
                controller: controller.controllerSearch,
                decoration: InputDecoration(
                    prefixIcon: IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        controller.searchClick();
                      },
                    ),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        controller.clearClick();
                      },
                    ),
                    hintText: LocaleKeys.eshop_shared_search.tr,
                    border: InputBorder.none),
              ),
            ),
          ),
          actions: [
            IconButton(
                onPressed: Get.back,
                icon: const Icon(Icons.arrow_forward_outlined))
          ],
        ),
      );
}
