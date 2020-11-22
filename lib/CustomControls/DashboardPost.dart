import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homeapp/Constants/DashboardConstants.dart';
import 'package:homeapp/Repositories/Models/Contracts/DashboardEntry.dart';
import 'package:homeapp/bloc/Authentication/authentication_bloc.dart';
import 'package:intl/intl.dart';
import 'package:like_button/like_button.dart';

class DashboardPost extends StatefulWidget {
  static const double elementTopPadding = 5;
  static const double nameSize = 17;
  static const double dateSize = 13;
  final String id;
  final Function(String, List<int>) likeCallback;
  DashboardEntry _entry;

  DashboardPost(this.id, dynamic firebaseEntry, this.likeCallback) {
    _entry = DashboardEntry();
    _entry.createdAt =
        DateTime.parse(firebaseEntry[DashboardConstants.createdAt]);
    _entry.createdByUserID = firebaseEntry[DashboardConstants.createdBy];
    String rawList = firebaseEntry[DashboardConstants.likedByUserIDs];
    _entry.likedByUserIDs = rawList == null || rawList.length == 0
        ? List<int>()
        : rawList.split(RegExp(r",")).map<int>((e) => int.parse(e)).toList();
    _entry.likes = _entry.likedByUserIDs.length;
    _entry.postText = firebaseEntry[DashboardConstants.post];
  }

  @override
  _DashboardPostState createState() => _DashboardPostState();
}

class _DashboardPostState extends State<DashboardPost>
    with SingleTickerProviderStateMixin {
  Animation<double> _animation;
  AnimationController _controller;
  static const double _iconSize = 25;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 1000),
        vsync: this,
        value: 0,
        lowerBound: 0,
        upperBound: 1);
    _animation =
        CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn);

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    _controller.animateTo(1, duration: Duration(milliseconds: 300));
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder(
              future: _getUserName(widget._entry.createdByUserID, context),
              builder: (context, snapshot) {
                if (snapshot.data != null && !snapshot.hasError) {
                  return Text(
                    snapshot.data,
                    style: TextStyle(
                        fontSize: DashboardPost.nameSize,
                        fontWeight: FontWeight.bold),
                  );
                }
                return Container(
                  width: 0,
                  height: 0,
                );
              },
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: DashboardPost.elementTopPadding),
              child: Text(
                DateFormat(
                  'EEEE d MMM h:mm',
                ).format(widget._entry.createdAt).toString(),
                style: TextStyle(
                    fontSize: DashboardPost.dateSize, color: Colors.grey),
              ),
            ),
            Padding(
                padding:
                    const EdgeInsets.only(top: DashboardPost.elementTopPadding),
                child: Text(widget._entry.postText)),
            LikeButton(
              size: 30,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              isLiked: determineLike(context),
              likeCount: widget._entry.likes,
              //likeCountAnimationDuration: Duration(milliseconds: 300),
              countBuilder: (likeCount, isLiked, text) {
                return FadeTransition(
                    opacity: _animation, child: Text(likeCount.toString()));
              },
              likeBuilder: (isLiked) {
                return Icon(Icons.arrow_upward,
                    size: _iconSize,
                    color: isLiked ? Colors.blue : Colors.grey);
              },
              padding: EdgeInsets.only(top: 10),
              onTap: (isLiked) => onLikeButtonTapped(isLiked, context),
            )
          ],
        ),
      ),
    );
  }

  bool determineLike(BuildContext context) {
    int userID = BlocProvider.of<AuthenticationBloc>(context).getUserIDSync();
    return widget._entry.likedByUserIDs.any((element) => element == userID);
  }

  Future<String> _getUserName(int id, BuildContext context) async {
    return await BlocProvider.of<AuthenticationBloc>(context)
        .getUsernameByID(widget._entry.createdByUserID);
  }

  Future<bool> onLikeButtonTapped(bool isLiked, BuildContext context) async {
    await _controller.animateBack(0, duration: Duration(milliseconds: 300));
    int userid = await _getUserID(context);
    bool result = false;
    if (isLiked) {
      result = this.widget._entry.likedByUserIDs.remove(userid);
      if (result) {}
    } else {
      this.widget._entry.likedByUserIDs.add(userid);
      result = true;
    }
    if (result) {
      await this
          .widget
          .likeCallback(this.widget.id, this.widget._entry.likedByUserIDs);
    }
    return !isLiked;
  }

  Future<int> _getUserID(BuildContext context) async {
    return await BlocProvider.of<AuthenticationBloc>(context).getUserID();
  }
}
