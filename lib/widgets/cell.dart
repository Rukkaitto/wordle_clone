import 'package:flutter/material.dart';
import 'package:wordle_clone/classes/cell_state.dart';

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
        color: state.color,
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
}
