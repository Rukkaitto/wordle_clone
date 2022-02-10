import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordle_clone/cubit/language_cubit.dart';
import 'package:wordle_clone/enums/language.dart';
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

    return BlocProvider(
      create: (context) => LanguageCubit(args.language),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          iconTheme: const IconThemeData(color: Colors.black),
          centerTitle: true,
          title: const Hero(
            tag: 'title',
            child: Material(
              color: Colors.transparent,
              child: Text(
                'Wordle',
                overflow: TextOverflow.visible,
                softWrap: false,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        body: SafeArea(
          child: FutureBuilder<String>(
            future: WordUtils.getRandomWord(
              min: 5,
              max: 5,
              language: args.language,
            ),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Game(word: snapshot.data!);
              } else if (snapshot.hasError) {
                throw snapshot.error!;
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }
}
