import 'package:flutter/material.dart';
import 'package:wordle_clone/views/game_view.dart';
import 'package:wordle_clone/views/home_view.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wordle',
      initialRoute: HomeView.routeName,
      routes: {
        HomeView.routeName: (context) => const HomeView(),
        GameView.routeName: (context) => const GameView(),
      },
    );
  }
}
