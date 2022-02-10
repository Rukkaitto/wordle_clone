import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:wordle_clone/enums/language.dart';
import 'package:wordle_clone/views/game_view.dart';

class HomeView extends StatefulWidget {
  static String routeName = '/';

  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  Language dropdownValue = Language.gb;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Hero(
              tag: 'title',
              child: Text(
                'Wordle',
                style: TextStyle(
                  fontSize: 60.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  GameView.routeName,
                  arguments: GameViewArguments(
                    dropdownValue,
                  ),
                );
              },
              child: const Text(
                'Play',
                style: TextStyle(
                  fontSize: 30.0,
                ),
              ),
            ),
            buildLanguageDropdown(),
          ],
        ),
      ),
    );
  }

  DropdownButton<Language> buildLanguageDropdown() {
    return DropdownButton<Language>(
      value: dropdownValue,
      items: Language.values.map((Language language) {
        return DropdownMenuItem(
          value: language,
          child: Flag.fromString(
            language.name,
            width: 40,
            borderRadius: 15,
          ),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          dropdownValue = value!;
        });
      },
    );
  }
}
