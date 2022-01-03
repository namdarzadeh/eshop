import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../../../../eshop.dart';
import '../../../infrastructures/utils/eshop_utils.dart';

class CustomAutocompleteWidget extends StatelessWidget {
  final TextEditingController controller;
  final List<String> tags;
  const CustomAutocompleteWidget({
    required this.controller,
    required this.tags,
    final Key? key,
  }) : super(key: key);

  @override
  Widget build(final BuildContext context) => Container(
        padding: EdgeInsets.all(EShopUtils.lableWidgetPadding()),
        width: 300,
        child: Autocomplete<String>(
          optionsBuilder: (final TextEditingValue textEditingValue) {
            controller.text = textEditingValue.text;
            if (textEditingValue.text == '') {
              return const Iterable<String>.empty();
            }
            return tags.where((final String option) =>
                option.contains(textEditingValue.text.toLowerCase()));
          },
          fieldViewBuilder: (final BuildContext context,
                  final TextEditingController textEditingController,
                  final FocusNode focusNode,
                  final VoidCallback onFieldSubmitted) =>
              TextFormField(
            controller: textEditingController,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: LocaleKeys.eshop_shared_tag.tr,
            ),
            focusNode: focusNode,
          ),
          onSelected: (final String selection) {
            controller.text = selection;
          },
        ),
      );
}
