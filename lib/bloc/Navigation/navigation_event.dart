part of 'navigation_bloc.dart';

abstract class NavigationEvent extends Equatable {
  const NavigationEvent();

  @override
  List<Object> get props => [];
}

class NavigationDashboard extends NavigationEvent {}

class NavigationDevices extends NavigationEvent {}

class NavigationTodoList extends NavigationEvent {}
