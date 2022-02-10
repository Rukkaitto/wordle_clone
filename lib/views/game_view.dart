import 'package:flutter/material.dart';
import 'package:wordle_clone/util/word_utils.dart';
import 'package:wordle_clone/widgets/game.dart';

class GameViewArguments {
  final Language language;

  GameViewArguments(this.language);
}

class GameView extends StatelessWidget {
  static String routeName = '/game';

  const GameView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as GameViewArguments;

    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<String>(
          future: WordUtils.getRandomWord(
            min: 5,
            max: 5,
            language: args.language,
          ),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Game(
                word: snapshot.data!,
                language: args.language,
              );
            } else if (snapshot.hasError) {
              throw snapshot.error!;
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
