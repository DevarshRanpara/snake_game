import 'package:event_bus/event_bus.dart';

class EventBusHelper {
  final EventBus _eventBus = EventBus();

  EventBus get eventBus => _eventBus;
}
