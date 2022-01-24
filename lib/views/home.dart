import 'package:flutter/material.dart';
import 'package:wordle_clone/widgets/game.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Game(word: 'world'),
      ),
    );
  }
}
