import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:homeapp/Repositories/AuthRepository.dart';
import 'package:meta/meta.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AAuthRepository repo;
  AuthenticationBloc(this.repo) : assert(repo != null);

  @override
  AuthenticationState get initialState => AuthenticationInitial();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    //change these to preserve login state, or not
    repo.deleteToken();
    /*if (event is AuthenticationStarted) {
      String token = await repo.retrieveToken();
      yield AuthenticationInProgress();

      if (token != null) {
        yield AuthenticationSucceeded();
      } else {
        yield AuthenticationFailed();
      }
    } else */
    if (event is AuthenticationLoggedIn) {
      yield AuthenticationSucceeded();
    } else if (event is AuthenticationLoggedOut) {
      //TODO
      await repo.deleteToken();
    }
  }
}
