import 'package:flutter/material.dart';
import 'package:homeapp/Repositories/Models/Contracts/TodoEntry.dart';
import 'package:intl/intl.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoElement extends StatelessWidget {
  final String id;
  final Function(TodoEntry, String) doneCallback;
  final TodoEntry _entry = TodoEntry();
  TodoElement(this.id, var map, this.doneCallback) {
    //It is an _InternalLinkedHashMap
    if (map.containsKey('createdAt'))
      this._entry.createdAt = DateTime.parse(map['createdAt']);
    if (map.containsKey('description'))
      this._entry.description = map['description'];
    if (map.containsKey('isDone')) this._entry.isDone = map['isDone'];
    if (map.containsKey('doneAt'))
      this._entry.doneAt = DateTime.parse(map['doneAt']);
    if (map.containsKey('createdByUserID')) {
      this._entry.createdByUserID = map['userID'];
      if (map.containsKey('doneByUserID'))
        this._entry.doneByUserID = map['userID'];
    }
  }
  //swipe to select, tap to open, floating action button press to submit done
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Column(children: [
      Slidable(
        key: Key(_entry.toString()),
        actionPane: SlidableStrechActionPane(
          key: Key(this._entry.toString()),
        ),
        actionExtentRatio: 0.25,
        actions: [
          IconSlideAction(
              caption: this._entry.isDone ? 'Undone' : 'Done',
              color: Colors.blue,
              icon: !this._entry.isDone ? Icons.done : Icons.redo,
              onTap: () => {doneCallback(_entry, id)}),
        ],
        child: ListTile(
          title: Text(
            this._entry.description,
            style: TextStyle(
                color: this._entry.isDone ? Colors.grey : Colors.white),
          ),
          isThreeLine: false,
          trailing: !this._entry.isDone
              ? Container(
                  width: 0,
                  height: 0,
                )
              : Icon(Icons.done),
          subtitle: !this._entry.isDone
              ? Text('Created: ' +
                  DateFormat(
                    'EEEE d MMM h:mm',
                  ).format(_entry.createdAt))
              : Text('Done: ' +
                  DateFormat(
                    'EEEE d MMM h:mm',
                  ).format(_entry.doneAt)),
          onTap: () => {
            //TODO open: Expandable package!
          },
        ),
      ),
      Divider(
        height: 0,
        color: Colors.grey,
      ),
    ]));
  }
}
