import 'package:flame/components.dart';

class GameConfig {

  // Defines the number of rows in the grid
  static const rows = 20;

  // Defines the number of columns in the grid
  static const columns = 20;

  // Cell size in px
  static const cellSize = 17;

  // Initial snake length
  static const initialSnakeLength = 3;

  // Initial snake's head index
  static final headIndex = Vector2(initialSnakeLength.toDouble(), (rows ~/ 2).toDouble());

  // Initial fps
  static const fps = 5.0;
}