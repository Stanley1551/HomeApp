part of 'navigation_bloc.dart';

@immutable
abstract class NavigationState {
  const NavigationState();
}

///The dashboard page
class NavigationInitial extends NavigationState {}

class NavigationToDevices extends NavigationState {}

class NavigationToTodoList extends NavigationState {}
