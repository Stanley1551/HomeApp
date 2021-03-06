import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homeapp/Behaviors/GlowlessBehavior.dart';
import 'package:homeapp/bloc/Authentication/authentication_bloc.dart';
import 'package:homeapp/bloc/Navigation/navigation_bloc.dart';
import 'package:homeapp/Services/AppLocalization.dart';

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
                  leading: Icon(Icons.dashboard),
                  title: Text(AppLocalization.of(context).dashboard),
                  onTap: () {
                    _navigationClicked(context, NavigationDashboard());
                  }),
              ListTile(
                leading: Icon(Icons.list),
                title: Text(AppLocalization.of(context).todoList),
                onTap: () {
                  _navigationClicked(context, NavigationTodoList());
                },
              ),
              ListTile(
                leading: Icon(Icons.event),
                title: Text(AppLocalization.of(context).events),
                onTap: () {
                  _navigationClicked(context, NavigationEvents());
                },
              ),
              ListTile(
                leading: Icon(Icons.shopping_bag),
                title: Text(AppLocalization.of(context).shoppingList),
                onTap: () {
                  _navigationClicked(context, NavigationShoppingList());
                },
              ),
              Divider(
                color: Colors.blueAccent,
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text(
                  AppLocalization.of(context).settings),
                onTap: () => _navigationClicked(context, NavigationSettings()),
              ),
              ListTile(
                onTap: () => _logoutClicked(context),
                leading: Icon(
                  Icons.exit_to_app,
                  color: Colors.redAccent,
                ),
                title: Text(
                  AppLocalization.of(context).logout,
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
            AppLocalization.of(context).logoutConf, Icons.warning,
            isYesNoQuestion: true));
    if (retval != null && retval) {
      BlocProvider.of<AuthenticationBloc>(context)
          .add(AuthenticationLoggedOut());
    }
  }
}
