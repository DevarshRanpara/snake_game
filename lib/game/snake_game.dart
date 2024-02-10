import 'package:flame/game.dart';

import 'component/background.dart';
import 'component/world.dart';
import 'config/game_config.dart';
import 'snake/grid.dart';
import 'snake/offsets.dart';

class SnakeGame extends FlameGame {
  Grid grid = Grid(GameConfig.rows, GameConfig.columns, GameConfig.cellSize);
  World? snakeWorld;
  OffSets offSets = OffSets(Vector2.zero());

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    offSets = OffSets(canvasSize);

    add(Background(GameConfig.cellSize));

    for (var rows in grid.cells) {
      for (var cell in rows) {
        add(cell);
      }
    }
    grid.generateFood();

    snakeWorld = World(grid);
    add(world);
  }
}
