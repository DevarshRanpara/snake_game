import 'package:flutter/material.dart';

class Stick extends StatelessWidget {
  const Stick({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 76,
      width: 76,
      decoration: BoxDecoration(
        color: const Color(0xFFC4C4C4),
        borderRadius: const BorderRadius.all(Radius.circular(100)),
        border: Border.all(color: Colors.white, width: 1),
      ),
    );
  }
}
