import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';

class WordUtils {
  /// Fetches a list of the 1000 most common nouns in English.
  static Future<List<String>> getWords(BuildContext context) async {
    String data = await DefaultAssetBundle.of(context)
        .loadString("assets/words/english.json");
    final result = List<String>.from(json.decode(data));
    return result;
  }

  /// Fetches a random word from the list of 1000 most common nouns in English,
  /// with its length being between [min] and [max].
  static Future<String> getRandomWord(BuildContext context,
      {required int min, required int max}) async {
    List<String> words = await getWords(context);
    int index = Random().nextInt(words.length);
    String word = words[index];
    if (word.length < min || word.length > max) {
      return getRandomWord(context, min: min, max: max);
    }
    return word;
  }
}
