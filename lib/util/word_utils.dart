// ignore_for_file: constant_identifier_names

import 'dart:math';
import 'package:flutter/services.dart';

enum Language {
  gb,
  fr,
}

class WordUtils {
  /// Checks if a word exists in the given language
  static Future<bool> wordExists(String word, Language language) async {
    final words = await getWords(language);
    return words.contains(word);
  }

  /// Fetches a list of all words in the given language.
  static Future<List<String>> getWords(
    Language language,
  ) async {
    return _getWordsFromFile("allowed_${language.name}.txt");
  }

  /// Fetches a list of the most common words in the given language.
  static Future<List<String>> getCommonWords(
    Language language,
  ) async {
    return _getWordsFromFile("guesses_${language.name}.txt");
  }

  static Future<List<String>> _getWordsFromFile(
    String fileName,
  ) async {
    String data = await rootBundle.loadString("assets/words/$fileName");
    final result = data.split("\n");
    return result;
  }

  /// Fetches a random word from the list of 1000 most common nouns in English,
  /// with its length being between [min] and [max].
  static Future<String> getRandomWord({
    required Language language,
    required int min,
    required int max,
  }) async {
    List<String> words = await getCommonWords(language);
    int index = Random().nextInt(words.length);
    String word = words[index];
    if (word.length < min || word.length > max) {
      return getRandomWord(min: min, max: max, language: language);
    }
    return word;
  }
}
