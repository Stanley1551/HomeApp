import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:homeapp/Constants/LocalEnums.dart';
import 'package:homeapp/Repositories/AuthRepository.dart';
import 'package:homeapp/Services/AppLocalization.dart';
import 'package:meta/meta.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  int getUserIDSync() {
    return _userID;
  }

  int _userID;
  final AAuthRepository repo;
  AuthenticationBloc(this.repo) : assert(repo != null);

  //TODO later: construct a base user class, and retrieve/save that
  Future<String> getUserName() async {
    return await repo.getAuthenticatedUsername();
  }

  Future<int> getUserID() async {
    return await repo.getAuthenticatedUserID();
  }

  Future<String> getUsernameByID(int id) async {
    return await repo.retrieveUserNameByID(id);
  }

  Future<bool> saveLocale(Locales locale) async {
    _loadLocale(locale);
    return await repo.saveLocale(locale);
  }

  Future<Locales> getLocale() async{
    var result = await repo.retrieveLocale();
    return result;
  }

  void _loadLocale(Locales locale){
    if(locale == Locales.England){
      AppLocalization.load(Locale('en','EN'));
    } else if(locale == Locales.Hungary){
      AppLocalization.load(Locale('hu','HU'));
    } else {
      AppLocalization.load(Locale('en','EN'));
    }
  }

  @override
  AuthenticationState get initialState => AuthenticationInitial();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    //change these to preserve login state, or not
    //repo.deleteToken();
    if (event is AuthenticationStarted) {
      String token = await repo.retrieveToken();
      yield AuthenticationInProgress();

      if (token != null) {
        await saveUserID();
        var locale = await repo.retrieveLocale();
        if(locale != null){
          _loadLocale(locale);
        }
        yield AuthenticationSucceeded();
      } else {
        yield AuthenticationFailed();
      }
    } else if (event is AuthenticationLoggedIn) {
      await saveUserID();
      yield AuthenticationSucceeded();
    } else if (event is AuthenticationLoggedOut) {
      await repo.deleteToken();
      yield AuthenticationExited();
    }
  }

  Future saveUserID() async {
    _userID = await repo.getAuthenticatedUserID();
  }
}
