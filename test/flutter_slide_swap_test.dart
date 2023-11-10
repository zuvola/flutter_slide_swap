import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_slide_swap/flutter_slide_swap.dart';

void main() {
  testWidgets('widget test', (WidgetTester tester) async {
    final controller = SlideController(length: 3);
    final keyA = UniqueKey();
    final keyB = UniqueKey();
    var app = MaterialApp(
      home: SafeArea(
        child: Scaffold(
          body: SlideSwap(
            controller: controller,
            children: <Widget>[
              ElevatedButton(
                key: keyA,
                onPressed: () {
                  controller.swapOrder(0, 2);
                },
                child: Text('A'),
              ),
              ElevatedButton(
                key: keyB,
                onPressed: () {
                  controller.swapOrderWithKey(keyA, 0);
                },
                child: Text('B'),
              ),
              ElevatedButton(
                onPressed: () {
                  controller.swapWithKey(keyA, keyB);
                },
                child: Text('C'),
              ),
            ],
          ),
        ),
      ),
    );
    await tester.pumpWidget(app);
    await tester.tap(find.widgetWithText(ElevatedButton, "A"));
    expect(controller.order, equals([2, 1, 0]));
    await tester.tap(find.widgetWithText(ElevatedButton, "B"));
    expect(controller.order, equals([0, 1, 2]));
    await tester.tap(find.widgetWithText(ElevatedButton, "C"));
    expect(controller.order, equals([1, 0, 2]));
  });
}
