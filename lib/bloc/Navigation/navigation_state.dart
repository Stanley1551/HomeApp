part of 'navigation_bloc.dart';

@immutable
abstract class NavigationState {
  final String title;
  const NavigationState(this.title);
}

///The dashboard page
class NavigationInitial extends NavigationState {
  NavigationInitial() : super('Welcome Home');
}

class NavigationToDevices extends NavigationState {
  NavigationToDevices() : super('Devices');
}

class NavigationToTodoList extends NavigationState {
  NavigationToTodoList() : super('To-do List');
}
