import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'ui/views/game_screen.dart';
import 'utils/service_locator.dart';
import 'utils/snake_store.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ServiceLocator.init();
  await GetIt.I.get<SnakeStore>().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const GameScreen(),
    );
  }
}
