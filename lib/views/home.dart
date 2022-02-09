import 'package:flutter/material.dart';
import 'package:wordle_clone/util/word_utils.dart';
import 'package:wordle_clone/widgets/game.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<String>(
          future: WordUtils.getRandomWord(
            min: 5,
            max: 5,
            language: Language.en,
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
    );
  }
}
