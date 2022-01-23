import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordle_clone/cubit/grid_cubit.dart';
import 'package:wordle_clone/keyboards/keyboard.dart';
import 'package:wordle_clone/widgets/keyboard_button.dart';
import 'package:wordle_clone/widgets/keyboard_key.dart';
import 'package:collection/collection.dart';

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
      children: keyboard.keys.mapIndexed(
        (index, row) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: buildKeyboard(context, index, row),
          );
        },
      ).toList(),
    );
  }

  List<Widget> buildKeyboard(BuildContext context, int index, String row) {
    final keys =
        row.characters.map((letter) => buildLetterKey(letter)).toList();
    if (index == 2) {
      keys.add(buildBackspaceKey(context));
      keys.insert(0, buildEnterKey(context));
    }
    return keys;
  }

  Widget buildEnterKey(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2),
      child: KeyboardButton(
        onTap: () {
          context.read<GridCubit>().submitAttempt();
        },
        color: Colors.green,
        width: 60.0,
        child: const Icon(
          Icons.check,
          color: Colors.white,
          size: 25.0,
        ),
      ),
    );
  }

  Widget buildBackspaceKey(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2),
      child: KeyboardButton(
        onTap: () {
          context.read<GridCubit>().removeLastCharacter();
        },
        color: Colors.red,
        width: 60.0,
        child: const Icon(
          Icons.backspace,
          color: Colors.white,
          size: 25.0,
        ),
      ),
    );
  }

  Widget buildLetterKey(String e) {
    return Padding(
      padding: const EdgeInsets.all(2),
      child: KeyboardKey(character: e),
    );
  }
}
