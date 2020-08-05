part of 'register_bloc.dart';

@immutable
abstract class RegisterEvent {}

class RegisterButtonPressed extends RegisterEvent {
  final String username;
  final String password;
  final String passwordAgain;

  RegisterButtonPressed(this.username, this.password, this.passwordAgain);
}

class BackToLoginPage extends RegisterEvent {}
