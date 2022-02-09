import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordle_clone/classes/cell.dart';
import 'package:wordle_clone/classes/cell_state.dart';
import 'package:wordle_clone/cubit/grid_cubit.dart';
import 'package:wordle_clone/widgets/cell_widget.dart';

class Grid extends StatelessWidget {
  final String word;
  final int maxAttempts;

  const Grid({
    required this.word,
    this.maxAttempts = 6,
    Key? key,
  }) : super(key: key);

  List<Widget> buildCells(List<List<Cell>> cells) {
    return List.generate(word.length * maxAttempts, (index) {
      int x = index % word.length;
      int y = index ~/ word.length;

      try {
        return CellWidget(
          cell: cells[y][x],
        );
      } catch (e) {
        return CellWidget(
          cell: Cell(state: CellState.empty),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade700,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(8.0),
      child: BlocConsumer<GridCubit, GridState>(
        listener: (context, state) {
          if (state.isWon) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('You won!'),
              ),
            );
          }
          if (state.isLost) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('You lost...'),
              ),
            );
          }
        },
        builder: (context, state) {
          return GridView(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: word.length,
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
            ),
            children: buildCells(state.cells),
          );
        },
      ),
    );
  }
}
