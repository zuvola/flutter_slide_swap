// Copyright 2020 zuvola. All rights reserved.

/// Flutter widget that swaps children with each other with slide animation.
library flutter_slide_swap;

import 'package:flutter/material.dart';

/// SlideSwap
///
/// {@tool sample}
///
/// This example shows a simple [SlideSwap].
///
/// ```dart
/// SlideSwap(
///   key: _globalKey,
///   children: <Widget>[
///     RaisedButton(
///       key: keyA,
///       onPressed: () {
///         SlideSwap.of(context).swapOrder(0, 1);
///       },
///       child: Text('A'),
///     ),
///     RaisedButton(
///       key: keyB,
///       onPressed: () {
///         _globalKey.currentState.swapWithKey(keyA, keyB);
///       },
///       child: Text('B'),
///     ),
///   ],
/// )
/// ```
/// {@end-tool}
///
class SlideSwap extends StatefulWidget {
  /// Creates a SlideSwap widget.
  ///
  /// The [children] argument must not be null.
  const SlideSwap({Key key, this.children = const <Widget>[]})
      : assert(children != null),
        super(key: key);

  /// The widgets below this widget in the tree.
  final List<Widget> children;

  @override
  SlideSwapState createState() => SlideSwapState();

  /// The [SlideSwapState] object from the closest instance of this class
  /// that encloses the given context.
  static SlideSwapState of(BuildContext context) {
    return context.findAncestorStateOfType<SlideSwapState>();
  }
}

/// State for a [SlideSwap].
///
/// Can change the display order of children.
/// Retrieve a [SlideSwapState] from the current [BuildContext] using [SlideSwapState.of].
class SlideSwapState extends State<SlideSwap>
    with SingleTickerProviderStateMixin {
  List<int> _order;
  _SlideSwapFlowDelegate _delegate;
  AnimationController _animationController;
  CurvedAnimation _animation;

  get order => _order;

  /// Swaps the order of the children using the two indexes.
  void swapOrder(int a, int b) {
    if (a == b) return;
    setState(() {
      int tmp = _order[a];
      _order[a] = _order[b];
      _order[b] = tmp;
      _animationController.reset();
      _animationController.forward();
    });
  }

  /// Use two keys to swap the order of the children.
  void swapWithKey(Key k1, Key k2) {
    var idx1 = widget.children.indexWhere((item) => item.key == k1);
    var idx2 = widget.children.indexWhere((item) => item.key == k2);
    var a = _order.indexWhere((item) => item == idx1);
    var b = _order.indexWhere((item) => item == idx2);
    this.swapOrder(a, b);
  }

  /// Swap the widget linked to key for index location
  void swapOrderWithKey(Key key, int index) {
    var idx = widget.children.indexWhere((item) => item.key == key);
    var a = _order.indexWhere((item) => item == idx);
    this.swapOrder(a, index);
  }

  @override
  void initState() {
    _animationController = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );
    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut);
    _delegate = _SlideSwapFlowDelegate(slideAnimation: _animation);
    _order = List<int>.generate(widget.children.length, (int index) => index);
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _delegate.order = _order;
    return Flow(
      delegate: _delegate,
      children: widget.children,
    );
  }
}

/// Delegate for a [Flow].
class _SlideSwapFlowDelegate extends FlowDelegate {
  final Animation<double> slideAnimation;

  List<int> _order;
  List<int> _oldOrder;

  get order => _order;

  set order(value) {
    if (_order != null) {
      _oldOrder = List.from(_order);
    } else {
      _oldOrder = List.from(value);
    }
    _order = List.from(value);
  }

  _SlideSwapFlowDelegate({this.slideAnimation})
      : super(repaint: slideAnimation);

  @override
  void paintChildren(FlowPaintingContext context) {
    double y = 0.0, y1 = 0.0, y2 = 0.0;
    var pos1 = new List(context.childCount);
    var pos2 = new List(context.childCount);
    for (var i = 0; i < context.childCount; i++) {
      var idx1 = _oldOrder[i];
      var idx2 = _order[i];
      pos1[idx1] = y1;
      pos2[idx2] = y2;
      y1 += context.getChildSize(idx1).height;
      y2 += context.getChildSize(idx2).height;
    }
    for (var i = 0; i < context.childCount; i++) {
      var dy = pos2[i] - pos1[i];
      y = pos1[i] + dy * slideAnimation.value;
      context.paintChild(
        i,
        transform: Matrix4.translationValues(0, y, 0),
      );
    }
  }

  @override
  bool shouldRepaint(_SlideSwapFlowDelegate oldDelegate) {
    return true;
  }
}
