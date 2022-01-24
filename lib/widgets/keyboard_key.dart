import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordle_clone/classes/cell_state.dart';
import 'package:wordle_clone/cubit/grid_cubit.dart';
import 'package:wordle_clone/widgets/keyboard_button.dart';

class KeyboardKey extends StatelessWidget {
  final String character;
  final Color color;

  const KeyboardKey({
    required this.character,
    this.color = Colors.grey,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GridCubit, GridState>(
      builder: (context, state) {
        final cellState = state.getMostRecentStateFromLetter(character);
        return KeyboardButton(
          color: cellState == CellState.empty ? color : cellState.color,
          onTap: () {
            context.read<GridCubit>().updateInput(character);
          },
          child: Text(
            character.toUpperCase(),
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      },
    );
  }
}
