import 'package:flutter/material.dart';
import 'package:flutter_slide_swap/flutter_slide_swap.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final keyA = UniqueKey();
  final keyC = UniqueKey();
  final controller = SlideController(length: 4);

  makeChild(key, text, color, height) {
    return Container(
      key: key,
      width: double.infinity,
      height: height,
      color: color,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('SlideSwap'),
        ),
        body: SafeArea(
          child: SlideSwap(
            controller: controller,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: RaisedButton(
                      onPressed: () {
                        controller.swapOrder(1, 3);
                      },
                      child: Text('1st ⇔ 3rd'),
                    ),
                  ),
                  Expanded(
                    child: RaisedButton(
                      onPressed: () {
                        controller.swapWithKey(keyA, keyC);
                      },
                      child: Text('A ⇔ C'),
                    ),
                  ),
                  Expanded(
                    child: RaisedButton(
                      onPressed: () async {
                        await controller.swapOrderWithKey(keyA, 3);
                        await controller.swapOrder(1, 2);
                        await controller.swapOrder(2, 3);
                      },
                      child: Text('Async'),
                    ),
                  ),
                ],
              ),
              makeChild(keyA, 'A', Colors.red, 20.0),
              makeChild(null, 'B', Colors.green, 30.0),
              makeChild(keyC, 'C', Colors.blue, 40.0),
            ],
          ),
        ),
      ),
    );
  }
}
