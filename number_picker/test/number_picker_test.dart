import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:number_picker/views/number_picker_widget.dart';

void main() {
  testWidgets('Number Picker Test', (final WidgetTester tester) async {
    int _number = 0;
    await tester.pumpWidget(MaterialApp(
        home: StatefulBuilder(
      builder: (context, setState) => NumberPickerWidget(
        number: _number,
        size: 10,
        sendNumber: (int i) {
          _number = i;
          setState(() {});
        },
      ),
    )));

    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsNothing);
    expect(find.text('2'), findsNothing);
    expect(find.text('3'), findsNothing);
    expect(find.text('4'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.remove));
    await tester.pump();
    await tester.tap(find.byIcon(Icons.remove));
    await tester.pump();
    await tester.tap(find.byIcon(Icons.remove));
    await tester.pump();
    await tester.tap(find.byIcon(Icons.remove));
    await tester.pump();

    expect(find.text('4'), findsNothing);
    expect(find.text('3'), findsNothing);
    expect(find.text('2'), findsNothing);
    expect(find.text('1'), findsNothing);
    expect(find.text('0'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.remove));
    await tester.pump();
    await tester.tap(find.byIcon(Icons.remove));
    await tester.pump();

    expect(find.text('-1'), findsNothing);
    expect(find.text('-2'), findsNothing);
    expect(find.text('0'), findsOneWidget);

    _number = -1;
    await tester.tap(find.byIcon(Icons.remove));
    await tester.pump();

    expect(find.text('-1'), findsNothing);
    expect(find.text('-2'), findsNothing);
    expect(find.text('0'), findsOneWidget);

    _number = -5;
    await tester.tap(find.byIcon(Icons.remove));
    await tester.pump();

    expect(find.text('-6'), findsNothing);
    expect(find.text('-5'), findsNothing);
    expect(find.text('-4'), findsNothing);
    expect(find.text('-3'), findsNothing);
    expect(find.text('-2'), findsNothing);
    expect(find.text('-1'), findsNothing);
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);
    expect(find.text('2'), findsNothing);
    expect(find.text('3'), findsNothing);
    expect(find.text('4'), findsNothing);
    expect(find.text('5'), findsNothing);
    expect(find.text('6'), findsNothing);
  });
}
