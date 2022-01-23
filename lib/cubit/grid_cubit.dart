import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'grid_state.dart';

class GridCubit extends Cubit<List<String>> {
  final int length;
  final int maxAttempts;

  GridCubit({
    required this.length,
    required this.maxAttempts,
  }) : super([]);

  void addAttempt(String attempt) {
    if (attempt.length == length) {
      emit(state + [""]);
    }
  }

  void updateInput(String input) {
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
