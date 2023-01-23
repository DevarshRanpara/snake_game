import 'package:flutter/material.dart';

import '../../utils/enums/direction_enum.dart';

class JoystickBase extends StatelessWidget {
  final SnakeEvent event;
  const JoystickBase({super.key, required this.event});

  double _passArcValue() {
    switch (event) {
      case SnakeEvent.top:
        return ArcValue.top;
      case SnakeEvent.bottom:
        return ArcValue.bottom;
      case SnakeEvent.left:
        return ArcValue.left;
      case SnakeEvent.right:
        return ArcValue.right;
      case SnakeEvent.standby:
        return 0;
      default:
        return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 162,
      width: 162,
      decoration: BoxDecoration(
          color: const Color(0xFFC5C5C5).withOpacity(0.5),
          shape: BoxShape.circle),
      child: event != SnakeEvent.standby
          ? CustomPaint(
              painter: ShowArc(_passArcValue()),
            )
          : const SizedBox(),
    );
  }
}

class ShowArc extends CustomPainter {
  final double location;
  final double _arcSize = 1.57;

  ShowArc(this.location);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Colors.red;
    canvas.drawArc(
      const Offset(0, 0) & const Size(162, 162),
      location,
      _arcSize,
      true,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class ArcValue {
  static const double right = 5.48;
  static const double top = 3.91;
  static const double left = 2.34;
  static const double bottom = 0.77;
}
