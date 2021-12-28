import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../../../../../eshop.dart';

class DeleteProductDialog extends StatelessWidget {
  @override
  Widget build(final BuildContext context) => AlertDialog(
        title: Text(
            LocaleKeys.eshop_business_exception_delete_product_successful.tr),
        actions: <Widget>[
          Row(
            textDirection: TextDirection.rtl,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: Text(LocaleKeys.eshop_shared_understand.tr),
              ),
            ],
          ),
        ],
      );
}
