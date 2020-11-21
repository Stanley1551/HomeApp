import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homeapp/CustomControls/CustomDrawer.dart';
import 'package:homeapp/Pages/MenuPages/DashboardPage.dart';
import 'package:homeapp/Pages/MenuPages/DevicesPage.dart';
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
              title: Text('Welcome Home'),
            ),
            body: BlocBuilder<NavigationBloc, NavigationState>(
                builder: (context, state) {
              if (state is NavigationInitial) {
                return DashBoardPage();
              } else if (state is NavigationToDevices) {
                return DevicesPage();
              } else if (state is NavigationToTodoList) {
                return TodoListPage();
              } else
                return DashBoardPage();
            })));
  }
}
