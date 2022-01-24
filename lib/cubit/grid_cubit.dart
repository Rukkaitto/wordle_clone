import 'package:bloc/bloc.dart';
import 'package:wordle_clone/classes/cell_state.dart';

class GridCubit extends Cubit<GridState> {
  final String word;
  final int maxAttempts;

  GridCubit({
    required this.word,
    required this.maxAttempts,
  }) : super(GridState());

  void submitAttempt() {
    if (state.attempts.isEmpty) return;
    final attempt = state.attempts.last;

    if (attempt.length == word.length) {
      final newStates = List<CellState>.filled(word.length, CellState.empty);

      for (int i = 0; i < attempt.length; i++) {
        final letter = attempt[i];
        newStates[i] = CellState.absent;
        if (word.contains(letter)) {
          newStates[i] = CellState.wrong;
        }
        if (word[i] == letter) {
          newStates[i] = CellState.correct;
        }
      }
      emit(GridState(
        attempts: state.attempts + [""],
        cellStates: state.cellStates + [newStates],
      ));
    }
  }

  void removeLastCharacter() {
    if (state.attempts.isEmpty) return;

    final lastAttempt = state.attempts.last;
    if (lastAttempt.isEmpty) return;

    final newAttempts = state.attempts.sublist(0, state.attempts.length - 1) +
        [lastAttempt.substring(0, lastAttempt.length - 1)];
    emit(GridState(
      attempts: newAttempts,
      cellStates: state.cellStates,
    ));
  }

  void updateInput(String character) {
    final input =
        state.attempts.isEmpty ? character : (state.attempts.last + character);
    // Replace last string in state with input
    if (input.length <= word.length) {
      if (state.attempts.isEmpty) {
        emit(
          GridState(
            attempts: state.attempts + [input],
            cellStates: state.cellStates,
          ),
        );
      } else {
        emit(
          GridState(
            attempts:
                state.attempts.sublist(0, state.attempts.length - 1) + [input],
            cellStates: state.cellStates,
          ),
        );
      }
    }
  }
}

class GridState {
  final List<String> attempts;
  final List<List<CellState>> cellStates;

  GridState({
    this.attempts = const [],
    this.cellStates = const [],
  });

  CellState getMostRecentStateFromLetter(String letter) {
    var state = CellState.empty;
    if (attempts.isEmpty) return state;
    final lockedAttempts = attempts.sublist(0, attempts.length - 1);
    if (lockedAttempts.isEmpty) return state;

    for (int i = 0; i < lockedAttempts.length; i++) {
      final attempt = attempts[i];
      final statesRow = cellStates[i];
      for (int j = 0; j < attempt.length; j++) {
        final attemptLetter = attempt[j];
        if (attemptLetter == letter) {
          state = statesRow[j];
        }
      }
    }
    return state;
  }
}
