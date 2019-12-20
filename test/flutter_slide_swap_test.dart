import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_slide_swap/flutter_slide_swap.dart';

void main() {
  testWidgets('widget test', (WidgetTester tester) async {
    var app = MaterialApp(
      home: SlideSwap(),
    );
    await tester.pumpWidget(app);
  });
}
