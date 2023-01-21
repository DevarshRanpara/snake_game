import 'package:flutter/material.dart';
import 'dart:math';
import 'package:vibration/vibration.dart';

import 'joystick_base.dart';
import 'joystick_event.dart';
import 'stick.dart';
import 'stick_offset_calculator.dart';

typedef OnPositionUpdate = void Function(JoystickEvent);

class JoyStick extends StatefulWidget {
  final OnPositionUpdate onPositionUpdate;
  const JoyStick({super.key, required this.onPositionUpdate});

  @override
  State<JoyStick> createState() => _JoyStickState();
}

class _JoyStickState extends State<JoyStick> {
  Offset _stickOffset = Offset.zero;
  Offset _startDragStickPosition = Offset.zero;
  final GlobalKey _baseKey = GlobalKey();
  JoystickEvent event = JoystickEvent.standby;

  void _getEvent() {
    double dx = _stickOffset.dx;
    double dy = _stickOffset.dy;
    JoystickEvent currentEvent = JoystickEvent.standby;
    var theta = atan2(dy, dx);
    theta *= 180 / pi;
    if (theta < 0) {
      theta += 360;
    }

    if (theta > 45 && theta < 135) {
      currentEvent = JoystickEvent.bottom;
    } else if (theta > 136 && theta < 225) {
      currentEvent = JoystickEvent.left;
    } else if (theta > 226 && theta < 315) {
      currentEvent = JoystickEvent.top;
    } else {
      currentEvent = JoystickEvent.right;
    }

    if (currentEvent != event) {
      event = currentEvent;
      Vibration.vibrate(duration: 5, amplitude: 200);
      widget.onPositionUpdate(event);
    }
  }

  void _onStart(DragStartDetails data) {
    setState(() {
      _startDragStickPosition = data.globalPosition;
    });
  }

  void _onUpdate(DragUpdateDetails data) {
    final baseRenderBox =
        _baseKey.currentContext!.findRenderObject()! as RenderBox;
    Offset calculatedOffset = StickOffsetCalculator.calculate(
      startDragStickPosition: _startDragStickPosition,
      currentDragStickPosition: data.globalPosition,
      baseSize: baseRenderBox.size,
    );
    _getEvent();
    setState(() {
      _stickOffset = calculatedOffset;
    });
  }

  void _onEnd(DragEndDetails data) {
    setState(() {
      _stickOffset = Offset.zero;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment(_stickOffset.dx, _stickOffset.dy),
      children: [
        JoystickBase(
          key: _baseKey,
        ),
        GestureDetector(
          onPanStart: _onStart,
          onPanUpdate: _onUpdate,
          onPanEnd: _onEnd,
          child: const Stick(),
        ),
      ],
    );
  }
}
