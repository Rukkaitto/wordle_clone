import 'package:bloc/bloc.dart';

class GridCubit extends Cubit<List<String>> {
  final int length;
  final int maxAttempts;

  GridCubit({
    required this.length,
    required this.maxAttempts,
  }) : super([]);

  void submitAttempt() {
    if (state.last.length == length) {
      emit(state + [""]);
    }
  }

  void removeLastCharacter() {
    if (state.isEmpty) return;

    final lastWord = state.last;
    if (lastWord.isEmpty) return;

    emit(state.sublist(0, state.length - 1) +
        [lastWord.substring(0, lastWord.length - 1)]);
  }

  void updateInput(String character) {
    final input = state.isEmpty ? character : (state.last + character);
    // Replace last string in state with input
    if (input.length <= length) {
      if (state.isEmpty) {
        emit(state + [input]);
      } else {
        emit(state.sublist(0, state.length - 1) + [input]);
      }
    }
  }
}
