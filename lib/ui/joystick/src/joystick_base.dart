import 'package:flutter/material.dart';

class JoystickBase extends StatelessWidget {
  const JoystickBase({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 162,
      width: 162,
      decoration: BoxDecoration(
        color: const Color(0xFFC5C5C5).withOpacity(0.5),
        shape: BoxShape.circle
      ),
    );
  }
}
