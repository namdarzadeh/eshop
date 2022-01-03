import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class NumberPickerWidget extends StatelessWidget {
  final void Function(int i) sendNumber;
  RxInt number = 0.obs;
  double size = 0;

  NumberPickerWidget({
    required this.sendNumber,
    required this.number,
    required this.size,
    final Key? key,
  }) : super(key: key);

  @override
  Widget build(final BuildContext context) => Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          children: [
            IconButton(
              iconSize: 15,
              padding: EdgeInsets.all(size),
              constraints: BoxConstraints(),
              icon: const Icon(Icons.add),
              onPressed: () {
                sendNumber(++number.value);
              },
            ),
            Obx(() => Text(number.toString())),
            IconButton(
              iconSize: 15,
              padding: EdgeInsets.all(size),
              constraints: BoxConstraints(),
              icon: const Icon(Icons.remove),
              onPressed: () {
                if (number.value != 0) {
                  sendNumber(--number.value);
                }
              },
            ),
          ],
        ),
      );
}
