import 'package:flutter/material.dart';

class KeyboardKey extends StatelessWidget {
  final String character;

  const KeyboardKey({
    required this.character,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 35.0,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(5.0),
      ),
      padding: const EdgeInsets.all(5.0),
      child: Center(
        child: Text(
          character.toUpperCase(),
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
