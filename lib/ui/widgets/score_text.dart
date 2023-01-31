import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../utils/event_bus/classes/score.dart';
import '../../utils/event_bus/event_bus_helper.dart';

class ScoreText extends StatefulWidget {

  const ScoreText({super.key});

  @override
  State<ScoreText> createState() => _ScoreTextState();
}

class _ScoreTextState extends State<ScoreText> {
  final EventBusHelper _eventBusHelper = GetIt.I.get<EventBusHelper>();
  int _currentScore = 0;

  @override
  void initState() {
    super.initState();
    _eventBusHelper.eventBus.on<Score>().listen((score) {
      setState(() {
        _currentScore = score.score;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _currentScore.toString(),
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w900,
      ),
    );
  }
}
