import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordle_clone/cubit/grid_cubit.dart';
import 'package:wordle_clone/widgets/cell.dart';
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
        return KeyboardButton(
          color:
              getColorFromState(state.getMostRecentStateFromLetter(character)),
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

  Color getColorFromState(CellState state) {
    switch (state) {
      case CellState.correct:
        return Colors.green;
      case CellState.wrong:
        return Colors.yellow;
      case CellState.absent:
        return Colors.black;
      case CellState.empty:
        return Colors.grey.shade800;
    }
  }
}
