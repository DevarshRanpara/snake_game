import '../../utils/enums/direction_enum.dart';
import 'snake.dart';

class CommandQueue {
  final List<SnakeEvent> directions = [];

  add(SnakeEvent touchPoint) {
    if (directions.length != 3) {
      directions.add(touchPoint);
    }
  }

  void evaluateNextInput(Snake snake) {
    if (directions.isNotEmpty) {
      var touchPoint = directions[0];
      directions.remove(touchPoint);
      snake.direction = touchPoint;
    }
  }
}
