import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homeapp/Behaviors/GlowlessBehavior.dart';
import 'package:homeapp/bloc/Authentication/authentication_bloc.dart';
import 'package:homeapp/bloc/Navigation/navigation_bloc.dart';

import 'CustomDialog.dart';

class CustomDrawer extends StatelessWidget {
  Color _backgroundColor = Color.fromARGB(205, 0, 0, 0);

  @override
  Widget build(context) {
    Future<String> _userName =
        BlocProvider.of<AuthenticationBloc>(context).getUserName();

    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          color: _backgroundColor,
          //border: BorderDirectional(end: BorderSide(color: Colors.blue))
        ),
        child: ScrollConfiguration(
          behavior: GlowlessBehavior(),
                  child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Flex(
                  direction: Axis.horizontal,
                  children: [
                    CircleAvatar(
                      child: Icon(
                        Icons.home,
                        size: 50,
                      ),
                      radius: 35,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: FutureBuilder<String>(
                        future: _userName,
                        initialData: 'User',
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Text(snapshot.data);
                          } else {
                            return Text('User');
                          }
                        },
                      ),
                    )
                  ],
                ),
                curve: Curves.easeInOut,
                decoration: BoxDecoration(
                    //color: _backgroundColor,
                    border: BorderDirectional(
                  bottom: BorderSide(color: Colors.blue),
                )),
              ),
              ListTile(
                  title: Text('Dashboard'),
                  onTap: () {
                    _navigationClicked(context, NavigationDashboard());
                  }),
              ListTile(
                title: Text('Todo list'),
                onTap: () {
                  _navigationClicked(context, NavigationTodoList());
                },
              ),
              ListTile(
                title: Text('Events'),
                onTap: () {
                  _navigationClicked(context, NavigationEvents());
                },
              ),
              ListTile(
                title: Text('Shopping list'),
                onTap: () {
                  _navigationClicked(context, NavigationShoppingList());
                },
              ),
              Divider(
                color: Colors.blueAccent,
              ),
              ListTile(
                onTap: () => _logoutClicked(context),
                leading: Icon(
                  Icons.exit_to_app,
                  color: Colors.redAccent,
                ),
                title: Text(
                  'Logout',
                  style: TextStyle(color: Colors.redAccent),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _navigationClicked(BuildContext context, NavigationEvent navEvent) {
    BlocProvider.of<NavigationBloc>(context).add(navEvent);
    Navigator.maybePop(context);
  }

  void _logoutClicked(BuildContext context) async {
    var retval = await showDialog(
        context: context,
        builder: (context) => CustomDialog(
            'Are you sure about logging out?', Icons.warning,
            isYesNoQuestion: true));
    if (retval) {
      BlocProvider.of<AuthenticationBloc>(context)
          .add(AuthenticationLoggedOut());
    }
  }
}
