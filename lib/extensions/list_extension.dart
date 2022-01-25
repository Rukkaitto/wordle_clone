extension ListExtension<T> on List<T> {
  /// Retrieves all elements except the last one.
  List<T> get withoutLast => sublist(0, length - 1);
}
