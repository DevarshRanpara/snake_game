import 'package:get_it/get_it.dart';

import '../game/snake/command_queue.dart';
import 'event_bus/event_bus_helper.dart';
import 'snake_store.dart';

class ServiceLocator {
  static void init() {
    GetIt.I.registerSingleton<CommandQueue>(CommandQueue());
    GetIt.I.registerSingleton<EventBusHelper>(EventBusHelper());
    GetIt.I.registerSingleton<SnakeStore>(SnakeStore());
  }
}
