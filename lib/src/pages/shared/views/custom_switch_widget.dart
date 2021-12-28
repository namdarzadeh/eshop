import 'package:flutter/material.dart';

class CustomSwitchWidget extends StatelessWidget {
  final void Function(bool i) sendCheckboxState;
  bool isSwitched = true;

  CustomSwitchWidget({
    required this.sendCheckboxState,
    required this.isSwitched,
    final Key? key,
  }) : super(key: key);

  @override
  Widget build(final BuildContext context) => Switch(
        value: isSwitched,
        onChanged: (final value) {
          isSwitched = value;
          sendCheckboxState(value);
        },
        activeTrackColor: Colors.lightGreenAccent,
        activeColor: Colors.green,
      );
}
