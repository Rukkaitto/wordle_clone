import 'package:flutter/material.dart';
import 'package:wordle_clone/widgets/keyboard_button.dart';

class KeyboardIconKey extends StatelessWidget {
  final IconData icon;
  final Function() onTap;
  final Color color;

  const KeyboardIconKey({
    required this.icon,
    required this.onTap,
    required this.color,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KeyboardButton(
      onTap: onTap,
      color: color,
      width: 60.0,
      child: Icon(
        icon,
        color: Colors.white,
        size: 30.0,
      ),
    );
  }
}
