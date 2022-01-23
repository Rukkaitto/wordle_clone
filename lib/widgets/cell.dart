import 'package:flutter/material.dart';

enum CellState {
  correct,
  wrong,
  absent,
  empty,
}

class Cell extends StatelessWidget {
  final String character;
  final CellState state;

  const Cell({
    required this.character,
    required this.state,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: getColorFromState(state),
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Center(
        child: Text(
          character.toUpperCase(),
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 50,
          ),
        ),
      ),
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
