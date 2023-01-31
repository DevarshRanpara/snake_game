import '../../utils/enums/direction_enum.dart';
import 'snake.dart';

class CommandQueue {
  final List<SnakeEvent> directions = [];

  add(SnakeEvent touchPoint) {
    if (directions.length != 1) {
      directions.add(touchPoint);
    }
  }

  void evaluateNextInput(Snake snake) {
    if (directions.isNotEmpty) {
      var touchPoint = directions[0];
      directions.remove(touchPoint);
      if(snake.direction == SnakeEvent.right && touchPoint == SnakeEvent.left) {
        return;
      }
      if(snake.direction == SnakeEvent.left && touchPoint == SnakeEvent.right) {
        return;
      }
      if(snake.direction == SnakeEvent.top && touchPoint == SnakeEvent.bottom) {
        return;
      }
      if(snake.direction == SnakeEvent.bottom && touchPoint == SnakeEvent.top) {
        return;
      }
      snake.direction = touchPoint;
    }
  }
}
