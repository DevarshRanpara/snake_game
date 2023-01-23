import 'package:flame/components.dart';
import 'package:flame/extensions.dart';

import '../config/styles.dart';
import '../snake_game.dart';

class Background extends PositionComponent with HasGameRef<SnakeGame> {
  Offset start = Offset.zero;
  Offset end = Offset.zero;

  final int cellSize;

  Background(this.cellSize);

  @override
  Future<void> onLoad() async {
    super.onLoad();
    start = gameRef.offSets.start.toOffset();
    end = gameRef.offSets.end.toOffset();
  }

  @override
  void render(Canvas canvas) {
    canvas.drawRect(Rect.fromPoints(start, end), Styles.bgColor);
  }
}
