import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../infrastructures/utils/eshop_utils.dart';

class CustomNumberLableWidget extends StatelessWidget {
  String title;
  final TextEditingController controller;
  CustomNumberLableWidget({
    required this.controller,
    required this.title,
    final Key? key,
  }) : super(key: key);

  @override
  Widget build(final BuildContext context) => Padding(
      padding: EdgeInsets.all(EShopUtils.lableWidgetPadding()),
      child: TextField(
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ],
          controller: controller,
          decoration: InputDecoration(
              border: const OutlineInputBorder(), labelText: title)));
}
