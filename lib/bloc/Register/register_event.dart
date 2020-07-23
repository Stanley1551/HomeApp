part of 'register_bloc.dart';

@immutable
abstract class RegisterEvent {}

class RegisterButtonPressed extends RegisterEvent {
  final String username;
  final String password;

  RegisterButtonPressed(this.username, this.password);
}

class BackToLoginPage extends RegisterEvent {}
