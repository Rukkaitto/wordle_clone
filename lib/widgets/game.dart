import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordle_clone/cubit/grid_cubit.dart';
import 'package:wordle_clone/keyboards/keyboard.dart';
import 'package:wordle_clone/widgets/grid.dart';
import 'package:wordle_clone/widgets/keyboard.dart';

class Game extends StatelessWidget {
  final String word;
  final int attempts;

  const Game({
    required this.word,
    this.attempts = 6,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GridCubit(
        length: word.length,
        maxAttempts: attempts,
      ),
      child: Builder(
        builder: (context) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Grid(word: word),
              ),
              KeyboardWidget(keyboard: Keyboard.azerty),
            ],
          );
        },
      ),
    );
  }
}
