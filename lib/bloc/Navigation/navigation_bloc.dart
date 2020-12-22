import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super();

  @override
  Stream<NavigationState> mapEventToState(
    NavigationEvent event,
  ) async* {
    if (event is NavigationDashboard) {
      yield NavigationInitial();
    } else if (event is NavigationTodoList) {
      yield NavigationToTodoList();
    } else if (event is NavigationEvents) {
      yield NavigationToEvents();
    } else if (event is NavigationShoppingList) {
      yield NavigationToShoppingList();
    }
  }

  @override
  NavigationState get initialState => NavigationInitial();
}
