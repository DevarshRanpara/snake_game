import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:get_it/get_it.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../game/snake/command_queue.dart';
import '../../game/snake_game.dart';
import '../../utils/de_bouncer.dart';
import '../../utils/enums/direction_enum.dart';
import '../../utils/event_bus/classes/snake_game_over.dart';
import '../../utils/event_bus/event_bus_helper.dart';
import '../joystick/joystick.dart';
import '../widgets/high_score_text.dart';
import '../widgets/score_text.dart';
import 'game_over.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final DeBouncer _searchDeBouncer = DeBouncer(milliseconds: 70);
  SnakeEvent classEvent = SnakeEvent.standby;
  final CommandQueue _commandQueue = GetIt.I.get<CommandQueue>();
  final EventBusHelper _eventBusHelper = GetIt.I.get<EventBusHelper>();

  @override
  void initState() {
    super.initState();
    _eventBusHelper.eventBus.on<SnakeGameOver>().listen((event) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
        return const GameOver();
      }));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      ScoreText(),
                      HighScore(),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  decoration: const BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  height: MediaQuery.of(context).size.width - 64,
                  width: MediaQuery.of(context).size.width - 64,
                  child: const GameWidget.controlled(
                    gameFactory: SnakeGame.new,
                  ),
                )
              ],
            ),
            Center(
              child: JoyStick(
                onPositionUpdate: (event) {
                  classEvent = event;
                  _searchDeBouncer.run(() {
                    _commandQueue.add(event);
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
