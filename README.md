# flutter_slide_swap

Flutter widget that swaps children with each other in slide animation.

[![pub package](https://img.shields.io/pub/v/flutter_slide_swap.svg)](https://pub.dartlang.org/packages/flutter_slide_swap)

<img src="https://github.com/zuvola/flutter_slide_swap/blob/master/example/screenshot.gif?raw=true" width="320px"/>


## Getting Started

To use this plugin, add `flutter_slide_swap` as a [dependency in your pubspec.yaml file](https://flutter.io/platform-plugins/).

```yaml
dependencies:
 flutter_slide_swap: 
```

Import the library in your file.

````dart
import 'package:flutter_slide_swap/flutter_slide_swap.dart';
````

See the `example` directory for a complete sample app using SlideSwap.
Or use the SlideSwap like below.

````dart
SlideSwap(
  key: _globalKey,
  children: <Widget>[
    RaisedButton(
      key: keyA,
      onPressed: () {
        SlideSwap.of(context).swapOrder(0, 1);
      },
      child: Text('A'),
    ),
    RaisedButton(
      key: keyB,
      onPressed: () {
        _globalKey.currentState.swapWithKey(keyA, keyB);
      },
      child: Text('B'),
    ),
  ],
)
````