import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordle_clone/util/word_utils.dart';

class LanguageCubit extends Cubit<Language> {
  LanguageCubit(Language initialState) : super(initialState);
}
