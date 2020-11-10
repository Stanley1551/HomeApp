import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'dart:async';
import 'dart:io' show Platform;

import 'package:homeapp/CustomControls/TodoElement.dart';

class TodoList extends StatelessWidget {
  var _databaseReference =
      FirebaseDatabase.instance.reference().child('TodoList');
  @override
  Widget build(BuildContext context) {
    return Center(
      child: FirebaseAnimatedList(
        reverse: false,
        sort: (a, b) => _sortRows(a, b),
        query: _databaseReference,
        itemBuilder: (context, snapshot, animation, index) =>
            _itemBuild(context, snapshot, animation, index),
      ),
    );
  }

  SizeTransition _itemBuild(BuildContext context, DataSnapshot snapshot,
      Animation<double> animation, int index) {
    return SizeTransition(
      sizeFactor: animation,
      child: TodoElement(snapshot.value),
    );
  }

  int _sortRows(DataSnapshot a, DataSnapshot b) {
    return DateTime.parse(b.value['createdAt'])
        .difference(DateTime.parse(a.value['createdAt']))
        .inDays;
  }
}
