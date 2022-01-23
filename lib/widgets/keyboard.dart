import 'package:flutter/material.dart';
import 'package:wordle_clone/keyboards/keyboard.dart';
import 'package:wordle_clone/widgets/keyboard_key.dart';

class KeyboardWidget extends StatelessWidget {
  final Keyboard keyboard;

  const KeyboardWidget({
    required this.keyboard,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: keyboard.keys.map(
        (row) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: row.characters
                .map(
                  (e) => Padding(
                    padding: const EdgeInsets.all(2),
                    child: KeyboardKey(character: e),
                  ),
                )
                .toList(),
          );
        },
      ).toList(),
    );
  }
}
