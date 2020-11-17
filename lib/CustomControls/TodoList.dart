import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homeapp/CustomControls/CustomDialog.dart';
import 'package:homeapp/CustomControls/CustomTextEntryDialog.dart';
import 'dart:async';
import '../Constants/TodoListConstants.dart';

import 'package:homeapp/CustomControls/TodoElement.dart';
import 'package:homeapp/Repositories/Models/Contracts/TodoEntry.dart';
import 'package:homeapp/bloc/Authentication/authentication_bloc.dart';

class TodoList extends StatelessWidget {
  var _databaseReference =
      FirebaseDatabase.instance.reference().child('TodoList');
  @override
  Widget build(BuildContext context) {
    return Center(
      child: FirebaseAnimatedList(
        reverse: false,
        sort: (a, b) => _sortRows(a, b),
        query: _databaseReference.endAt(true).orderByChild(TodoListConstants.isDone).limitToFirst(10),
        itemBuilder: (context, snapshot, animation, index) =>
            _itemBuild(context, snapshot, animation, index),
      ),
    );
  }

  void triggerAdd(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => CustomTextEntryDialog(
        'Name the task',
        Icons.list,
        submitCallback: (value) => _insertListItem(value, context),
      ),
    );
  }

  Future<void> _insertListItem(String elementName, BuildContext context) async {
    //validation
    if(elementName == null || elementName.trim().length == 0)
    {
      return;
    }
    elementName = elementName.trim();
    
    var newChild = _databaseReference.push();
    Map<String, dynamic> values = Map<String, dynamic>();
    values[TodoListConstants.createdBy] = await BlocProvider.of<AuthenticationBloc>(context).getUserID();
    values[TodoListConstants.createdAt] = DateTime.now().toString();
    values[TodoListConstants.isDone] = false;
    values[TodoListConstants.desc] = elementName;
    try {
      await newChild.set(values);
    } catch (e) {
      showDialog(
          context: context,
          child: CustomDialog(
              'Something went wrong during the process.', Icons.warning));
    }
  }

  SizeTransition _itemBuild(BuildContext context, DataSnapshot snapshot,
      Animation<double> animation, int index) {
    return SizeTransition(
      sizeFactor: animation,
      child: TodoElement(snapshot.key, snapshot.value,
          (entry, key) => _modifyDoneChange(entry, key, context)),
    );
  }

  int _sortRows(DataSnapshot a, DataSnapshot b) {
    var aValue = a.value[TodoListConstants.isDone] ? -DateTime.parse(a.value[TodoListConstants.doneAt]).microsecondsSinceEpoch : DateTime.parse(a.value[TodoListConstants.createdAt]).microsecondsSinceEpoch;
    var bValue = b.value[TodoListConstants.isDone] ? -DateTime.parse(b.value[TodoListConstants.doneAt]).microsecondsSinceEpoch : DateTime.parse(b.value[TodoListConstants.createdAt]).microsecondsSinceEpoch;
    return bValue-aValue;
  }

  Future<void> _modifyDoneChange(
      TodoEntry entry, String key, BuildContext context) async {
    var child = _databaseReference.child(key);
    Map<String, dynamic> map = Map<String, dynamic>();
    if (entry.isDone) {
      //set undone
      map[TodoListConstants.doneAt] = null;
      map[TodoListConstants.doneBy] = null;
      map[TodoListConstants.isDone] = false;
    } else {
      //set done
      map[TodoListConstants.doneAt] = DateTime.now().toString();
      map[TodoListConstants.doneBy] =
          await BlocProvider.of<AuthenticationBloc>(context).getUserID();
      map[TodoListConstants.isDone] = true;
    }
    try {
      await child.update(map);
    } catch (e) {
      showDialog(
          context: context,
          child: CustomDialog(
              'Something went wrong during the process.', Icons.warning));
    }
  }
}
