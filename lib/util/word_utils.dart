import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';

class WordUtils {
  static Future<List<String>> getWords(BuildContext context) async {
    String data = await DefaultAssetBundle.of(context)
        .loadString("assets/words/english.json");
    final result = List<String>.from(json.decode(data));
    return result;
  }

  static Future<String> getRandomWord(BuildContext context) async {
    List<String> words = await getWords(context);
    int index = Random().nextInt(words.length);
    String word = words[index];
    if (word.length < 4 || word.length > 5) {
      return getRandomWord(context);
    }
    return word;
  }
}
