import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordle_clone/cubit/grid_cubit.dart';
import 'package:wordle_clone/cubit/language_cubit.dart';
import 'package:wordle_clone/enums/language.dart';
import 'package:wordle_clone/widgets/grid.dart';
import 'package:wordle_clone/widgets/keyboard_widget.dart';

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
    final language = context.read<LanguageCubit>().state;
    return BlocProvider(
      create: (context) => GridCubit(
        word: word,
        maxAttempts: attempts,
        language: language,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Grid(word: word),
          ),
          const Spacer(),
          KeyboardWidget(keyboard: language.keyboardLayout),
          const Flexible(
            child: SizedBox(
              height: 100.0,
            ),
          ),
        ],
      ),
    );
  }
}
