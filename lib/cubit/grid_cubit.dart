import 'package:bloc/bloc.dart';
import 'package:wordle_clone/classes/cell.dart';
import 'package:wordle_clone/classes/cell_state.dart';
import 'package:wordle_clone/enums/language.dart';
import 'package:wordle_clone/extensions/list_extension.dart';
import 'package:wordle_clone/util/word_utils.dart';

class GridCubit extends Cubit<GridState> {
  final String word;
  final int maxAttempts;
  final Language language;

  GridCubit({
    required this.word,
    required this.maxAttempts,
    required this.language,
  }) : super(GridState());

  /// Emits a new [GridState] with evaluated cell states for the last row
  /// if the last row is complete.
  void submitAttempt() async {
    if (state.isWon || state.isLost) return;

    List<Cell> lastRow = _getLastRow(state.cells);

    final solution = lastRow.map((e) => e.character).join();

    if (!await WordUtils.wordExists(solution, language)) {
      emit(state.copyWith(wordDoesntExist: true));
      return;
    } else {
      emit(state.copyWith(wordDoesntExist: false));
    }

    // Checks if the attempt's length is equal to the word's length
    if (lastRow.length == word.length) {
      for (int i = 0; i < lastRow.length; i++) {
        final letter = lastRow[i].character!;

        // Mark the current state as absent for now
        lastRow[i] = Cell(character: letter, state: CellState.absent);

        // If the letter is in the word
        // and the row doesn't contain a correct cell with the same letter,
        // mark the current state as wrong for now
        if (word.contains(letter) &&
            !lastRow
                .contains(Cell(state: CellState.correct, character: letter))) {
          lastRow[i] = Cell(character: letter, state: CellState.wrong);
        }
        // If the letter is in the same position as the current letter in the word,
        // mark the current state as correct
        if (word[i] == letter) {
          lastRow[i] = Cell(character: letter, state: CellState.correct);
        }

        // Emit the state with the evaluated row
        emit(state.copyWith(cells: state.cells.withoutLast + [lastRow]));

        // Add a delay to reveal the next letter
        await Future.delayed(const Duration(milliseconds: 300));
      }

      // If all the last row's cells are correct, emit a new state with isWon set to true
      if (lastRow.every((cell) => cell.state == CellState.correct)) {
        emit(state.copyWith(isWon: true));
      } else {
        // If the current row is the last row, emit a new state with isLost set to true
        if (state.cells.length == maxAttempts) {
          emit(state.copyWith(isLost: true));
        } else {
          // When the cell states are evaluated,
          // add a new row to the grid
          emit(state.copyWith(cells: state.cells + [[]]));
        }
      }
    }
  }

  /// Emits a new [GridState] with the last column of the last row removed.
  void removeLastCharacter() {
    if (state.isWon || state.isLost) return;

    List<Cell> lastRow = _getLastRow(state.cells);

    if (lastRow.isEmpty) return;

    final newRow = lastRow.withoutLast;

    emit(state.copyWith(cells: state.cells.withoutLast + [newRow]));
  }

  /// Emits a new [GridState] with a given [character] added to the last row,
  /// if the last row is not full.
  void updateInput(String character) {
    if (state.isWon || state.isLost) return;
    assert(character.length == 1);

    List<Cell> lastRow = _getLastRow(state.cells);

    // Locks the length of the input to the word's length
    if (lastRow.length <= word.length) {
      // Adds the character to the last row
      lastRow += [Cell(character: character, state: CellState.empty)];

      if (state.cells.isEmpty) {
        // If this is the first row, just add the row to the grid
        emit(state.copyWith(cells: [lastRow]));
      } else {
        // If this is not the first row, replace the last row with the new one
        emit(state.copyWith(cells: state.cells.withoutLast + [lastRow]));
      }
    }
  }

  /// Creates a copy of the last row in a grid.
  List<T> _getLastRow<T>(List<List<T>> grid) {
    return grid.isEmpty ? [] : List.from(grid.last);
  }
}

class GridState {
  final List<List<Cell>> cells;
  final bool isWon;
  final bool isLost;
  final bool wordDoesntExist;

  GridState({
    this.isWon = false,
    this.isLost = false,
    this.wordDoesntExist = false,
    this.cells = const [],
  });

  GridState copyWith(
      {List<List<Cell>>? cells,
      bool? isWon,
      bool? isLost,
      bool? wordDoesntExist}) {
    return GridState(
      cells: cells ?? this.cells,
      isWon: isWon ?? this.isWon,
      isLost: isLost ?? this.isLost,
      wordDoesntExist: wordDoesntExist ?? false,
    );
  }

  /// Gets the most recent [CellState] from a given [character].
  CellState getMostRecentStateFromLetter(String character) {
    assert(character.length == 1);

    var state = CellState.empty;
    if (cells.isEmpty) return state;
    // The locked attempts are the rows that have already been evaluated
    final lockedAttempts = cells.withoutLast;
    if (lockedAttempts.isEmpty) return state;

    // Iterating over locked attempts
    for (var attempt in lockedAttempts) {
      // Iterating over the cells of the attempt
      for (var cell in attempt) {
        final attemptLetter = cell.character;
        // If the cell's character is the same as the letter
        // and the saved state is not correct,
        // save the state of the cell
        if (attemptLetter == character && state != CellState.correct) {
          state = cell.state;
        }
      }
    }

    return state;
  }
}
