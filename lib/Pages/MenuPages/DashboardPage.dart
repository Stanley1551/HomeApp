import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homeapp/Constants/DashboardConstants.dart';
import 'package:homeapp/CustomControls/CustomTextEntryDialog.dart';
import 'package:homeapp/CustomControls/DashboardPost.dart';
import 'package:homeapp/bloc/Authentication/authentication_bloc.dart';

class DashBoardPage extends StatelessWidget {
  DatabaseReference _databaseReference =
      FirebaseDatabase.instance.reference().child('Dashboard');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FirebaseAnimatedList(
        sort: (DataSnapshot a, DataSnapshot b) {
          return a.hashCode - b.hashCode;
        },
        query: _databaseReference, //TODO add limit!
        defaultChild: Center(child: CircularProgressIndicator()),
        itemBuilder: (BuildContext context, DataSnapshot snapshot,
                Animation<double> animation, index) =>
            _itemBuild(context, snapshot, animation, index),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => addPressed(context),
        backgroundColor: Colors.blue,
        child: Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
    );
  }

  SizeTransition _itemBuild(BuildContext context, DataSnapshot snapshot,
      Animation<double> animation, int index) {
    return SizeTransition(
      sizeFactor: animation,
      child: DashboardPost(snapshot.key, snapshot.value, likePost),
    );
  }

  Future likePost(String key, List<int> newList) async {
    String value = newList.join(",");
    await _databaseReference
        .child(key)
        .child(DashboardConstants.likedByUserIDs)
        .set(value);
  }

  Future submitPost(String msg, BuildContext context) async {
    if (msg != null && msg.length > 0 && msg.trim().length > 0) {
      msg = msg.trim();
      var newChild = _databaseReference.push();
      Map<String, dynamic> values = Map<String, dynamic>();
      values[DashboardConstants.createdAt] = DateTime.now().toString();
      values[DashboardConstants.createdBy] =
          await BlocProvider.of<AuthenticationBloc>(context).getUserID();
      values[DashboardConstants.likedByUserIDs] = "";
      values[DashboardConstants.post] = msg;

      await newChild.set(values);

      BlocProvider.of<AuthenticationBloc>(context).composePushNotification(
        'New post!',
        ((msg.length > 20) ? msg.substring(0,20)+'...' : msg));
    }
  }

  void addPressed(BuildContext context) {
    showDialog(
        context: context,
        builder: (ctx) { return CustomTextEntryDialog('Add a message', Icons.edit,
            submitCallback: (msg) => submitPost(msg, context));});
  }
}
