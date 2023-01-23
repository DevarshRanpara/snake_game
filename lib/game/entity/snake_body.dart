import 'dart:ui';

import 'package:flame/components.dart';

import '../config/styles.dart';

class SnakeBody {
  static void render(Canvas canvas, Vector2 location, int cellSize) {
    canvas.drawRect(
      Rect.fromPoints(
        findStart(location, cellSize),
        findEnd(location, cellSize),
      ),
      Styles.snakeBody,
    );
  }

  static Offset findStart(Vector2 location, int cellSize) =>
      Offset(location.x, location.y);

  static Offset findEnd(Vector2 location, int cellSize) =>
      Offset(location.x + cellSize, location.y + cellSize);
}
