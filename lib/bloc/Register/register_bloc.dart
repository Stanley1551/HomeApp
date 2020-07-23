import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:homeapp/Repositories/AuthRepository.dart';
import 'package:meta/meta.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  AuthRepository repo;

  RegisterBloc(this.repo) : assert(repo != null); // : super(RegisterInitial());

  @override
  RegisterState get initialState => RegisterInitial();

  @override
  Stream<RegisterState> mapEventToState(
    RegisterEvent event,
  ) async* {
    if (event is BackToLoginPage) {
      yield SwitchToLogin();
    } else if (event is RegisterButtonPressed) {
      bool registerResult = await repo.register(event.username, event.password);
    }
  }
}
