import 'dart:ui';

import 'package:flame/components.dart';
import 'package:get_it/get_it.dart';

import '../../utils/enums/direction_enum.dart';
import '../../utils/event_bus/classes/snake_game_over.dart';
import '../../utils/event_bus/event_bus_helper.dart';
import '../config/game_config.dart';
import '../config/styles.dart';
import '../snake/command_queue.dart';
import '../snake/grid.dart';
import '../snake/score_manager.dart';
import '../snake/snake.dart';
import '../snake_game.dart';
import 'cell.dart';
import 'dynamic_fps_position_component.dart';

class World extends DynamicFpsPositionComponent with HasGameRef<SnakeGame> {
  final Grid _grid;
  final Snake _snake = Snake();
  final CommandQueue _commandQueue = GetIt.I.get<CommandQueue>();
  final EventBusHelper _eventBusHelper = GetIt.I.get<EventBusHelper>();
  final ScoreManager _scoreManager = ScoreManager();

  bool gameOver = false;

  World(this._grid) : super(GameConfig.fps) {
    _initializeSnake();
  }

  @override
  void updateDynamic(double dt) {
    if (!gameOver) {
      _commandQueue.evaluateNextInput(_snake);

      var nextCell = _getNextCell();

      if (nextCell != Grid.border) {
        if (_snake.checkCrash(nextCell)) {
          gameOver = true;
          _eventBusHelper.eventBus.fire(SnakeGameOver());
        } else {
          if (nextCell.cellType == CellType.food) {
            _scoreManager.increment();
            _snake.grow(nextCell);
            _grid.generateFood();
          } else {
            _snake.move(nextCell);
          }
        }
      } else {
        gameOver = true;
        _eventBusHelper.eventBus.fire(SnakeGameOver());
      }
    }
  }

  @override
  void render(Canvas canvas) {
    if (gameOver) {
      canvas.drawRect(
          Rect.fromLTRB(
              2, 2, gameRef.canvasSize.x - 2, gameRef.canvasSize.y - 2),
          Styles.gameOver);
    }
  }

  void _initializeSnake() {
    var headIndex = GameConfig.headIndex;
    var snakeLength = GameConfig.initialSnakeLength;

    for (int i = 0; i < snakeLength; i++) {
      var snakePart =
          _grid.findCell(headIndex.x.toInt() - i, headIndex.y.toInt());
      _snake.addCell(snakePart);
      if (i == 0) {
        _snake.setHead(snakePart);
      }
    }
  }

  Cell _getNextCell() {
    var row = _snake.head.row;
    var column = _snake.head.column;

    switch (_snake.direction) {
      case SnakeEvent.top:
        row--;
        break;
      case SnakeEvent.right:
        column++;
        break;
      case SnakeEvent.bottom:
        row++;
        break;
      case SnakeEvent.left:
        column--;
        break;
      case SnakeEvent.standby:
        break;
    }
    return _grid.findCell(column, row);
  }
}
