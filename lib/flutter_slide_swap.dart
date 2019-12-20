// Copyright 2019 zuvola. All rights reserved.

///
library flutter_slide_swap;

import 'package:flutter/material.dart';

class SlideSwap extends StatelessWidget {
  const SlideSwap({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned.fill(
          child: Container(color:Colors.green),
        ),
      ],
    );
  }
}
