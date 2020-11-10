import 'package:flutter/material.dart';
import 'package:homeapp/CustomControls/DashboardPost.dart';

class DashBoardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [DashboardPost()],
    );
  }
}
