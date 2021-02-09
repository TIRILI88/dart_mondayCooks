import 'package:flutter/material.dart';
import 'dart:async';

class Debouncer {

  final int millisenconds;
  VoidCallback action;
  Timer _timer;

  Debouncer({this.millisenconds});

  run(VoidCallback action) {
    if (null != _timer) {
      _timer.cancel();
    }
    _timer = Timer(Duration(microseconds: millisenconds), action);
  }
}