import 'package:get_it/get_it.dart';

import '../../utils/event_bus/classes/score.dart';
import '../../utils/event_bus/event_bus_helper.dart';

class ScoreManager {
  int _currentScore = 0;
  // int _highScore = 0;
  final EventBusHelper _eventBusHelper = GetIt.I.get<EventBusHelper>();

  void increment() {
    _currentScore++;
    _eventBusHelper.eventBus.fire(Score(_currentScore));
  }
}