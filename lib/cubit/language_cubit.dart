import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordle_clone/enums/language.dart';

class LanguageCubit extends Cubit<Language> {
  LanguageCubit(Language initialState) : super(initialState);
}
