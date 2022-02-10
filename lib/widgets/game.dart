import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordle_clone/classes/keyboard.dart';
import 'package:wordle_clone/cubit/grid_cubit.dart';
import 'package:wordle_clone/util/word_utils.dart';
import 'package:wordle_clone/widgets/grid.dart';
import 'package:wordle_clone/widgets/keyboard_widget.dart';

class Game extends StatelessWidget {
  final String word;
  final int attempts;
  final Language language;

  const Game({
    required this.word,
    required this.language,
    this.attempts = 6,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GridCubit(
        word: word,
        maxAttempts: attempts,
        language: language,
      ),
      child: Builder(
        builder: (context) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Grid(
                  word: word,
                  language: language,
                ),
              ),
              const Spacer(),
              KeyboardWidget(keyboard: Keyboard.azerty),
              const Flexible(
                child: SizedBox(
                  height: 100.0,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
