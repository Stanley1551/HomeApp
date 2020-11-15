import 'package:flutter/material.dart';

import 'package:homeapp/CustomControls/TodoList.dart';

class TodoListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TodoList body = TodoList();

    return Scaffold(
      body: body,
      floatingActionButton: FloatingActionButton(
        onPressed: () => body.triggerAdd(context),
        backgroundColor: Colors.blue,
        child: Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
    );
  }
}
