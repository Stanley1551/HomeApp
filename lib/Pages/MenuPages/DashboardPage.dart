import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:homeapp/Constants/DashboardConstants.dart';
import 'package:homeapp/CustomControls/DashboardPost.dart';

class DashBoardPage extends StatelessWidget {
  DatabaseReference _databaseReference =
      FirebaseDatabase.instance.reference().child('Dashboard');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FirebaseAnimatedList(
        query: _databaseReference,
        defaultChild: Center(child: CircularProgressIndicator()),
        itemBuilder: (BuildContext context, DataSnapshot snapshot,
                Animation<double> animation, index) =>
            _itemBuild(context, snapshot, animation, index),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
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
}
