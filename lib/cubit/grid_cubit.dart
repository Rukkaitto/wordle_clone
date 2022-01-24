import 'package:bloc/bloc.dart';
import 'package:wordle_clone/classes/cell.dart';
import 'package:wordle_clone/classes/cell_state.dart';
import 'package:wordle_clone/extensions/list_extension.dart';

class GridCubit extends Cubit<GridState> {
  final String word;
  final int maxAttempts;

  GridCubit({
    required this.word,
    required this.maxAttempts,
  }) : super(
          GridState(),
        );

  void submitAttempt() async {
    List<Cell> lastRow = _getLastRow(state.cells);

    // Checks if the attempt's length is equal to the word's length
    if (lastRow.length == word.length) {
      for (int i = 0; i < lastRow.length; i++) {
        final letter = lastRow[i].character!;

        // Mark the current state as absent for now
        lastRow[i] = Cell(character: letter, state: CellState.absent);
        // If the letter is in the word, mark the current state as wrong for now
        if (word.contains(letter)) {
          lastRow[i] = Cell(character: letter, state: CellState.wrong);
        }
        // If the letter is in the same position as the current letter in the word,
        // mark the current state as correct
        if (word[i] == letter) {
          lastRow[i] = Cell(character: letter, state: CellState.correct);
        }

        // Emit the new state
        emit(GridState(
          cells: state.cells.withoutLast + [lastRow],
        ));
        await Future.delayed(const Duration(milliseconds: 300));
      }
      emit(GridState(
        cells: state.cells + [[]],
      ));
    }
  }

  void removeLastCharacter() {
    List<Cell> lastRow = _getLastRow(state.cells);

    if (lastRow.isEmpty) return;

    final newRow = lastRow.withoutLast;

    emit(GridState(
      cells: state.cells.withoutLast + [newRow],
    ));
  }

  void updateInput(String character) {
    List<Cell> lastRow = _getLastRow(state.cells);

    if (lastRow.length <= word.length) {
      lastRow += [Cell(character: character, state: CellState.empty)];
      if (state.cells.isEmpty) {
        emit(GridState(
          cells: [lastRow],
        ));
      } else {
        emit(GridState(
          cells: state.cells.withoutLast + [lastRow],
        ));
      }
    }
  }

  List<T> _getLastRow<T>(List<List<T>> list) {
    return list.isEmpty ? [] : List.from(list.last);
  }
}

class GridState {
  final List<List<Cell>> cells;

  GridState({this.cells = const []});

  CellState getMostRecentStateFromLetter(String letter) {
    var state = CellState.empty;
    if (cells.isEmpty) return state;
    // The locked attempts are the attempts that have already been submitted
    final lockedAttempts = cells.withoutLast;
    if (lockedAttempts.isEmpty) return state;

    // Iterating over locked attempts
    for (var attempt in lockedAttempts) {
      // Iterating over the letters of the attempt
      for (var cell in attempt) {
        final attemptLetter = cell.character;
        if (attemptLetter == letter && state != CellState.correct) {
          state = cell.state;
        }
      }
    }

    return state;
  }
}
