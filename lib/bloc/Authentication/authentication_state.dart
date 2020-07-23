part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationState {}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationInProgress extends AuthenticationState {}

class AuthenticationFailed extends AuthenticationState {}

class AuthenticationSucceeded extends AuthenticationState {}
