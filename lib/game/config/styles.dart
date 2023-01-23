import 'dart:ui';

import 'package:flame/palette.dart';

class Styles {
  static Paint bgColor = const PaletteEntry(Color(0xFFC6C6C6)).paint();
  static Paint red = BasicPalette.red.paint();

  static Paint snakeBody = BasicPalette.black.paint();

  static Paint gameOver = BasicPalette.red.paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 0;
}
