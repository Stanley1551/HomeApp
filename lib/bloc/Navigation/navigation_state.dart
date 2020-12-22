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

class NavigationToEvents extends NavigationState {
  NavigationToEvents() : super('Events');
}

class NavigationToTodoList extends NavigationState {
  NavigationToTodoList() : super('To-do List');
}

class NavigationToShoppingList extends NavigationState {
  NavigationToShoppingList() : super('Shopping List');
}
