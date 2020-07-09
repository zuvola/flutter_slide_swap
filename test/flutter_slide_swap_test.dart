import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_slide_swap/flutter_slide_swap.dart';

void main() {
  testWidgets('widget test', (WidgetTester tester) async {
    final GlobalKey<SlideSwapState> _globalKey = GlobalKey();
    final keyA = UniqueKey();
    final keyB = UniqueKey();
    var app = MaterialApp(
      home: SafeArea(
        child: Scaffold(
          body: SlideSwap(
            key: _globalKey,
            children: <Widget>[
              RaisedButton(
                key: keyA,
                onPressed: () {
                  _globalKey.currentState.swapOrder(0, 2);
                },
                child: Text('A'),
              ),
              RaisedButton(
                key: keyB,
                onPressed: () {
                  _globalKey.currentState.swapOrderWithKey(keyA, 0);
                },
                child: Text('B'),
              ),
              RaisedButton(
                onPressed: () {
                  _globalKey.currentState.swapWithKey(keyA, keyB);
                },
                child: Text('C'),
              ),
            ],
          ),
        ),
      ),
    );
    await tester.pumpWidget(app);
    await tester.tap(find.widgetWithText(RaisedButton, "A"));
    expect(_globalKey.currentState.order, equals([2, 1, 0]));
    await tester.tap(find.widgetWithText(RaisedButton, "B"));
    expect(_globalKey.currentState.order, equals([0, 1, 2]));
    await tester.tap(find.widgetWithText(RaisedButton, "C"));
    expect(_globalKey.currentState.order, equals([1, 0, 2]));
  });
}
