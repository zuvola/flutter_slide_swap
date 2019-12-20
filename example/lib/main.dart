import 'package:flutter/material.dart';
import 'package:flutter_slide_swap/flutter_slide_swap.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('SlideSwap'),
        ),
        body: SafeArea(
          bottom: false,
          child: SlideSwap(),
        ),
      ),
    );
  }
}
