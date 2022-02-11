import 'package:flag/flag.dart';
import 'package:wordle_clone/classes/keyboard.dart';

enum Language {
  gb,
  fr,
}

extension LanguageExtension on Language {
  Keyboard get keyboardLayout {
    switch (this) {
      case Language.gb:
        return Keyboard.qwerty;
      case Language.fr:
        return Keyboard.azerty;
    }
  }

  Flag get flag {
    return Flag.fromString(
      name,
      width: 40,
      borderRadius: 15,
    );
  }
}
