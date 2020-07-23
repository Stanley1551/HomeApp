part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class LoginButtonPressed extends LoginEvent {
  final username;
  final password;

  LoginButtonPressed(this.username, this.password);
}

class RegisterButtonPressed extends LoginEvent {}
