import 'package:get_it/get_it.dart';

import '../game/snake/command_queue.dart';
import 'event_bus/event_bus_helper.dart';

class ServiceLocator {
  static void init() {
    GetIt.I.registerSingleton<CommandQueue>(CommandQueue());
    GetIt.I.registerSingleton<EventBusHelper>(EventBusHelper());
  }
}
