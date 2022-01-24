extension ListExtension<T> on List<T> {
  List<T> get withoutLast => sublist(0, length - 1);
}
