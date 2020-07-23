import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:homeapp/Repositories/AuthRepository.dart';
import 'package:homeapp/bloc/Authentication/authentication_bloc.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthenticationBloc authBloc;
  final AuthRepository repo;

  LoginBloc(this.authBloc, this.repo)
      : assert(repo != null),
        assert(authBloc != null);

  @override
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginButtonPressed) {
      yield LoginInProgress();

      bool result = await repo.login(event.username, event.password);

      if (!result) {
        yield LoginFailed();
      } else {
        authBloc.add(AuthenticationLoggedIn());
      }
    } else if (event is RegisterButtonPressed) {
      yield SwitchToRegister();
    }
  }
}
