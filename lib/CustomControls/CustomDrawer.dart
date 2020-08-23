import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[900],
          //border: BorderDirectional(end: BorderSide(color: Colors.blue))
        ),
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
                      padding: EdgeInsets.only(left: 15), child: Text('Name'))
                ],
              ),
              curve: Curves.easeInOut,
              decoration: BoxDecoration(
                  color: Colors.grey[900],
                  border: BorderDirectional(
                    bottom: BorderSide(color: Colors.grey),
                  )),
            ),
            ListTile(title: Text('Dashboard')),
            ListTile(
              title: Text('Todo list'),
              onTap: () {},
            ),
            Divider(
              color: Colors.grey,
            ),
            ListTile(
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
    );
  }
}
