import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scavenger_app/Repositories/auth_repo.dart';
import 'package:scavenger_app/bloc/auth-cubit/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitialState());

  AuthRepo authRepo = AuthRepo();

  Future<void> Login(String email, String password) async {
    emit(AuthLoadingInState());
    try {
      var user = await authRepo.login(email, password);
      emit(AuthLoggedInState(user: user));
    } catch (e) {
      emit(AuthErrorState(error: e.toString()));
    }
  }

  Future<void> sigUp(String email, String password) async {
    emit(AuthLoadingInState());
    try {
      var user = await authRepo.signup(email, password);
      emit(AuthRegisterdInState(user: user));
    } catch (e) {
      emit(AuthErrorState(error: e.toString()));
    }
  }
}
