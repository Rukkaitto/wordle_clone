import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LettersCubit extends Cubit<LettersState> {
  LettersCubit() : super(LettersState());

  void addCorrectLetter(String letter) {
    if (letter.length == 1) {
      state.correct.add(letter);
    } else {
      throw Exception('Letter must be a single character');
    }
  }

  void addWrongLetter(String letter) {
    if (letter.length == 1) {
      state.wrong.add(letter);
    } else {
      throw Exception('Letter must be a single character');
    }
  }

  void addAbsentLetter(String letter) {
    if (letter.length == 1) {
      state.absent.add(letter);
    } else {
      throw Exception('Letter must be a single character');
    }
  }
}

class LettersState {
  final List<String> correct;
  final List<String> wrong;
  final List<String> absent;

  LettersState({
    this.correct = const [],
    this.wrong = const [],
    this.absent = const [],
  });

  Color getColorFromLetters(String letter) {
    if (correct.contains(letter)) {
      return Colors.green;
    }
    if (wrong.contains(letter)) {
      return Colors.yellow;
    }
    if (absent.contains(letter)) {
      return Colors.black;
    }
    return Colors.grey.shade800;
  }
}
