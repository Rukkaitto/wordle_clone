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

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade700,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<GridCubit, GridState>(
        builder: (context, state) {
          return GridView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: word.length * maxAttempts,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: word.length,
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
            ),
            itemBuilder: (context, index) {
              int x = index % word.length;
              int y = index ~/ word.length;
              try {
                final cell = state.cells[y][x];
                return CellWidget(
                  cell: cell,
                );
              } catch (e) {
                return CellWidget(
                  cell: Cell(state: CellState.empty),
                );
              }
            },
          );
        },
      ),
    );
  }
}
