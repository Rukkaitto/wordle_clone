import 'package:equatable/equatable.dart';
import 'package:wordle_clone/classes/cell_state.dart';

class Cell extends Equatable {
  final String character;
  final CellState state;

  const Cell({required this.character, required this.state});

  @override
  List<Object?> get props => [character, state];
}
