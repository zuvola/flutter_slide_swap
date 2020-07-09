import 'package:flutter/material.dart';
import 'package:flutter_slide_swap/flutter_slide_swap.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final GlobalKey<SlideSwapState> _globalKey = GlobalKey();
  final keyA = UniqueKey();
  final keyC = UniqueKey();

  makeChild(key, text, color, width, height) {
    return Container(
      key: key,
      width: width,
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
          bottom: false,
          child: LayoutBuilder(builder: (context, constraints) {
            return SlideSwap(
              key: _globalKey,
              children: <Widget>[
                Container(
                  child: Builder(builder: (context) {
                    return Row(
                      children: <Widget>[
                        Expanded(
                          child: RaisedButton(
                            onPressed: () {
                              SlideSwap.of(context).swapOrder(1, 3);
                            },
                            child: Text('1st ⇔ 3rd'),
                          ),
                        ),
                        Expanded(
                          child: RaisedButton(
                            onPressed: () {
                              SlideSwap.of(context).swapWithKey(keyA, keyC);
                            },
                            child: Text('A ⇔ C'),
                          ),
                        ),
                        Expanded(
                          child: RaisedButton(
                            onPressed: () {
                              _globalKey.currentState.swapOrderWithKey(keyA, 2);
                            },
                            child: Text('A ⇒ 2nd'),
                          ),
                        ),
                      ],
                    );
                  }),
                ),
                makeChild(keyA, 'A', Colors.red, constraints.maxWidth, 20.0),
                makeChild(null, 'B', Colors.green, constraints.maxWidth, 30.0),
                makeChild(keyC, 'C', Colors.blue, constraints.maxWidth, 40.0),
              ],
            );
          }),
        ),
      ),
    );
  }
}
