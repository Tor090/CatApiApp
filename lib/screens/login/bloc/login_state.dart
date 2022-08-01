part of 'login_bloc.dart';

abstract class LoginState {}

class InitialState extends LoginState {}

class LoginingState extends LoginState {}

class LogedState extends LoginState {}

class ErrorState extends LoginState {
  ErrorState(this.error);

  final String error;
}
