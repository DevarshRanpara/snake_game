import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../utils/event_bus/classes/score.dart';
import '../../utils/event_bus/event_bus_helper.dart';

class HighScore extends StatefulWidget {
  const HighScore({super.key});

  @override
  State<HighScore> createState() => _HighScoreState();
}

class _HighScoreState extends State<HighScore> {
  final EventBusHelper _eventBusHelper = GetIt.I.get<EventBusHelper>();
  int _highScore = 0;

  @override
  void initState() {
    super.initState();
    _eventBusHelper.eventBus.on<HighScoreEvent>().listen((score) {
      setState(() {
        _highScore = score.highScore;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(LucideIcons.trophy),
        Text(
          _highScore.toString(),
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w900,
          ),
        ),
      ],
    );
  }
}
