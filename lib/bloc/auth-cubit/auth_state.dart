import 'package:firebase_auth/firebase_auth.dart';

class AuthState {}

class AuthInitialState extends AuthState {}

class AuthLoggedInState extends AuthState {
  final User? user;

  AuthLoggedInState({required this.user});
}

class AuthRegisterdInState extends AuthState {
  final User? user;

  AuthRegisterdInState({required this.user});
}

class AuthLoadingInState extends AuthState {}

class AuthErrorState extends AuthState {
  final String? error;

  AuthErrorState({required this.error});
}
