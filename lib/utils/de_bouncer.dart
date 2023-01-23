import 'package:flutter/foundation.dart';
import 'dart:async';

class DeBouncer {
  final int? milliseconds;
  VoidCallback? action;
  Timer? _timer;

  DeBouncer({this.milliseconds});

  run(VoidCallback action) {
    if (_timer != null) {
      _timer!.cancel();
    }

    _timer = Timer(Duration(milliseconds: milliseconds!), action);
  }
}
