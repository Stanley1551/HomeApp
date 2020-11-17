import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:homeapp/Constants/TodoListConstants.dart';
import 'package:homeapp/Repositories/Models/Contracts/TodoEntry.dart';
import 'package:intl/intl.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoElement extends StatelessWidget {
  final String id;
  final Function(TodoEntry, String) doneCallback;
  final TodoEntry _entry = TodoEntry();
  TodoElement(this.id, var map, this.doneCallback) {
    //It is an _InternalLinkedHashMap
    if (map.containsKey(TodoListConstants.createdAt))
      this._entry.createdAt = DateTime.parse(map[TodoListConstants.createdAt]);
    if (map.containsKey(TodoListConstants.desc))
      this._entry.description = map[TodoListConstants.desc];
    if (map.containsKey(TodoListConstants.isDone)) this._entry.isDone = map[TodoListConstants.isDone];
    if (map.containsKey(TodoListConstants.doneAt))
      this._entry.doneAt = DateTime.parse(map[TodoListConstants.doneAt]);
    if (map.containsKey(TodoListConstants.createdBy))
      this._entry.createdByUserID = map[TodoListConstants.createdBy];
      if (map.containsKey(TodoListConstants.doneBy))
        this._entry.doneByUserID = map[TodoListConstants.doneBy];
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
        child: ExpandablePanel(
          hasIcon: false, //not deprecated...
                  header: ListTile(
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
          ),
          expanded: Padding(padding: EdgeInsets.only(left: 17, bottom: 5, top: 0),
          child: Text(this._entry.isDone ?'By '+ this._entry.doneByUserID.toString() :'By '+ this._entry.createdByUserID.toString(), style: TextStyle(color:Colors.grey,),),
        ),
      ),
      
    ),Divider(
        height: 0,
        color: Colors.grey,
      ),]));
  }
}
