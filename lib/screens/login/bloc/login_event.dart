part of 'login_bloc.dart';

abstract class LoginEvent {}

class GoogleLoginEvent extends LoginEvent {
  GoogleLoginEvent();
}

class FacebookLoginEvent extends LoginEvent {
  FacebookLoginEvent();
}
