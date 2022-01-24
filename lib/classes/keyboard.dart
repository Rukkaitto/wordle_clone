class Keyboard {
  final List<String> keys;

  Keyboard({required this.keys});

  static get azerty {
    return Keyboard(
      keys: [
        "azertyuiop",
        "qsdfghjklm",
        "wxcvbn",
      ],
    );
  }

  static get qwerty {
    return Keyboard(
      keys: [
        "qwertyuiop",
        "asdfghjkl",
        "zxcvbnm",
      ],
    );
  }
}
