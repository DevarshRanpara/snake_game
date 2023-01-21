import 'package:flutter/material.dart';

import '../joystick/joystick.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: JoyStick(
          onPositionUpdate: (event) {
            print(event);
          },
        ),
      ),
    );
  }
}
