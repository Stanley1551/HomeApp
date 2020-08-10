import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:homeapp/Repositories/AuthRepository.dart';
import 'package:homeapp/Repositories/Models/Contracts/RegisterResult.dart';
import 'package:meta/meta.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  AAuthRepository repo;

  RegisterBloc(this.repo) : assert(repo != null); // : super(RegisterInitial());

  @override
  RegisterState get initialState => RegisterInitial();

  @override
  Stream<RegisterState> mapEventToState(
    RegisterEvent event,
  ) async* {
    if (event is BackToLoginPage) {
      //not yet implemented, back button should do the trick
      yield SwitchToLogin();
    } else if (event is RegisterButtonPressed) {
      yield RegisterInProgress();
      if (event.password.compareTo(event.passwordAgain) != 0) {
        yield RegisterFailed('Password fields must match!');
        return;
      }
      RegisterResult registerResult =
          await repo.register(event.username, event.password);

      if (registerResult.isSuccess) {
        yield SwitchToLogin();
      } else {
        yield RegisterFailed(registerResult.message);
      }
    }
  }
}
