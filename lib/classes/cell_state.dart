import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

enum CellStateType {
  correct,
  wrong,
  absent,
  empty,
}

class CellState extends Equatable {
  final Color color;
  final CellStateType type;

  const CellState({
    required this.color,
    this.type = CellStateType.empty,
  });

  static get correct => const CellState(
        color: Colors.green,
        type: CellStateType.correct,
      );

  static get wrong => CellState(
        color: Colors.yellow.shade700,
        type: CellStateType.wrong,
      );

  static get absent => const CellState(
        color: Colors.black,
        type: CellStateType.absent,
      );

  static get empty => CellState(
        color: Colors.grey.shade800,
        type: CellStateType.empty,
      );

  @override
  List<Object?> get props => [type];
}
