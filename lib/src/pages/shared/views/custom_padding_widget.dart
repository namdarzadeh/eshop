import 'package:flutter/material.dart';

import '../../../infrastructures/utils/eshop_utils.dart';

class CustomPaddingWidget extends StatelessWidget {
  final Widget widget;
  const CustomPaddingWidget({
    required this.widget,
    final Key? key,
  }) : super(key: key);

  @override
  Widget build(final BuildContext context) => Padding(
      padding: EdgeInsets.all(EShopUtils.allWidgetPadding()), child: widget);
}
