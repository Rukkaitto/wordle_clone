import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordle_clone/classes/cell.dart';
import 'package:wordle_clone/classes/cell_state.dart';
import 'package:wordle_clone/cubit/grid_cubit.dart';
import 'package:wordle_clone/util/word_utils.dart';
import 'package:wordle_clone/views/game_view.dart';
import 'package:wordle_clone/widgets/cell_widget.dart';

class Grid extends StatelessWidget {
  final String word;
  final int maxAttempts;
  final Language language;

  const Grid({
    required this.word,
    required this.language,
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
      child: BlocConsumer<GridCubit, GridState>(
        listener: gridListener,
        builder: gridBuilder,
      ),
    );
  }

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

  Widget gridBuilder(BuildContext context, GridState state) {
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
  }

  void gridListener(BuildContext context, GridState state) {
    if (state.isWon) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.SUCCES,
        title: 'You won!',
        btnOkText: 'Play again',
        btnOkOnPress: () {
          Navigator.of(context).pushReplacementNamed(
            GameView.routeName,
            arguments: GameViewArguments(language),
          );
        },
      ).show();
    }
    if (state.isLost) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.ERROR,
        title: 'You lost... (the word was: ${word.toUpperCase()})',
        btnOkText: 'Play again',
        btnOkOnPress: () {
          Navigator.of(context).pushReplacementNamed(
            GameView.routeName,
            arguments: GameViewArguments(language),
          );
        },
      ).show();
    }
    if (state.wordDoesntExist) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("That word doesn't exist..."),
        ),
      );
    }
  }
}
