import 'package:get_it/get_it.dart';

import '../game/snake/command_queue.dart';

class ServiceLocator {
  static void init() {
    GetIt.I.registerSingleton<CommandQueue>(CommandQueue());
  }
}
