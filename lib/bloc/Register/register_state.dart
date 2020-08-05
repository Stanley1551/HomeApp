part of 'register_bloc.dart';

@immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class SwitchToLogin extends RegisterState {}

class RegisterFailed extends RegisterState {
  final String message;

  RegisterFailed(this.message);
}
