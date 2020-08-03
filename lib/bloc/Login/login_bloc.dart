import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:homeapp/Repositories/AuthRepository.dart';
import 'package:homeapp/Repositories/Models/Contracts/LoginResult.dart';
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

      LoginResult result = await repo.login(event.username, event.password);

      if (!result.isSuccess) {
        yield LoginFailed(result.message);
      } else {
        authBloc.add(AuthenticationLoggedIn());
      }
    } else if (event is RegisterButtonPressed) {
      yield SwitchToRegister();
    }
  }
}
