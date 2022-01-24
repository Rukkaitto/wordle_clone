import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordle_clone/cubit/grid_cubit.dart';
import 'package:wordle_clone/classes/keyboard.dart';
import 'package:wordle_clone/widgets/keyboard_icon_key.dart';
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
      child: KeyboardIconKey(
        icon: Icons.check_circle_outline_rounded,
        color: Colors.green,
        onTap: () {
          context.read<GridCubit>().submitAttempt();
        },
      ),
    );
  }

  Widget buildBackspaceKey(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2),
      child: KeyboardIconKey(
        icon: Icons.backspace_outlined,
        color: Colors.red,
        onTap: () {
          context.read<GridCubit>().removeLastCharacter();
        },
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
