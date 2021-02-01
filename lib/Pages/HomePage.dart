import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homeapp/CustomControls/CustomDrawer.dart';
import 'package:homeapp/Pages/MenuPages/DashboardPage.dart';
import 'package:homeapp/Pages/MenuPages/EventsPage.dart';
import 'package:homeapp/Pages/MenuPages/SettingsPage.dart';
import 'package:homeapp/Pages/MenuPages/ShoppingListPage.dart';
import 'package:homeapp/Pages/MenuPages/TodoListPage.dart';
import 'package:homeapp/Repositories/AuthRepository.dart';
import 'package:homeapp/bloc/Navigation/navigation_bloc.dart';

class HomePage extends StatelessWidget {
  final AuthRepository repo;

  HomePage(this.repo);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NavigationBloc>(
        create: (context) {
          return NavigationBloc();
        },
        child: Scaffold(
            drawer: Theme(
                data:
                    Theme.of(context).copyWith(canvasColor: Colors.transparent),
                child: CustomDrawer()),
            appBar: AppBar(
              title: BlocBuilder<NavigationBloc, NavigationState>(
                builder: (context, state) {
                  return Text(state.title);
                },
              ),
            ),
            body: BlocBuilder<NavigationBloc, NavigationState>(
                builder: (context, state) {
              if (state is NavigationInitial) {
                return DashBoardPage();
              } else if (state is NavigationToEvents) {
                return EventsPage();
              } else if (state is NavigationToTodoList) {
                return TodoListPage();
              } else if (state is NavigationToShoppingList) {
                return ShoppingListPage();
              } else if (state is NavigationToSettings) {
                return SettingsPage();
              }

              else
                return DashBoardPage();
            })));
  }
}
