import 'package:flutter/material.dart';

class NumberPickerWidget extends StatelessWidget {
  final void Function(int i) sendNumber;
  int number = 0;
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
                sendNumber(number + 1);
              },
            ),
            Text(number.toString()),
            IconButton(
              iconSize: 15,
              padding: EdgeInsets.all(size),
              constraints: BoxConstraints(),
              icon: const Icon(Icons.remove),
              onPressed: () {
                if (number <= 0) {
                  sendNumber(0);
                } else {
                  sendNumber(number - 1);
                }
              },
            ),
          ],
        ),
      );
}
