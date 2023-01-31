import 'package:get_it/get_it.dart';

import '../../utils/event_bus/classes/score.dart';
import '../../utils/event_bus/event_bus_helper.dart';
import '../../utils/snake_store.dart';

class ScoreManager {
  int _currentScore = 0;
  int _highScore = 0;
  final EventBusHelper _eventBusHelper = GetIt.I.get<EventBusHelper>();
  final SnakeStore _store = GetIt.I.get<SnakeStore>();

  ScoreManager() {
    _highScore = _store.getHighScore();
    _eventBusHelper.eventBus.fire(HighScoreEvent(_highScore));
  }

  void increment() {
    _currentScore++;
    _eventBusHelper.eventBus.fire(Score(_currentScore));
    if (_currentScore >= _highScore) {
      _highScore = _currentScore;
      _store.setHighScore(_highScore);
      _eventBusHelper.eventBus.fire(HighScoreEvent(_highScore));
    }
  }
}