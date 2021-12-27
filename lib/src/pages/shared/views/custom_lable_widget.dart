import 'package:flutter/material.dart';

import '../../../infrastructures/utils/eshop_utils.dart';

class CustomLableWidget extends StatelessWidget {
  String title;
  final TextEditingController controller;
  CustomLableWidget({
    required this.controller,
    required this.title,
    final Key? key,
  }) : super(key: key);

  @override
  Widget build(final BuildContext context) => Padding(
        padding: EdgeInsets.all(EShopUtils.lableWidgetPadding()),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: title,
          ),
        ),
      );
}
