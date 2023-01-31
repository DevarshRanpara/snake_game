import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:get_it/get_it.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../game/component/world.dart';
import '../../game/snake/command_queue.dart';
import '../../game/snake_game.dart';
import '../../utils/de_bouncer.dart';
import '../../utils/enums/direction_enum.dart';
import '../joystick/joystick.dart';
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

  @override
  void initState() {
    super.initState();
    eventBus.on<SnakeGameOver>().listen((event) {
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
                    children: [
                      const Text(
                        '000000',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Icon(LucideIcons.trophy),
                          Text(
                            '000000',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
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
