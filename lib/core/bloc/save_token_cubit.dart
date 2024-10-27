import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../pref.dart';

part 'save_token_state.dart';

class SaveUserTokenCubit extends Cubit<SaveTokenState> {
  SaveUserTokenCubit({required this.pref})
      : super(SaveTokenState(token: pref.getUserToken()));

  final Pref pref;

  Future<void> saveToken(String token) async {
    pref.saveUserToken(token);
    emit(SaveTokenState(token: token));
  }

  void clearToken() {
    pref.clearUserToken();
    emit(const SaveTokenState(token: ''));
  }
}
