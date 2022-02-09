import 'package:flutter/material.dart';
import 'package:wordle_clone/views/home.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wordle',
      initialRoute: '/',
      routes: {
        '/': (context) => const Home(),
      },
    );
  }
}
