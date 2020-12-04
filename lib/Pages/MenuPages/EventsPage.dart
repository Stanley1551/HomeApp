import 'package:flutter/material.dart';
import 'package:homeapp/CustomControls/CustomCalendar.dart';
import 'package:homeapp/CustomControls/CustomEventList.dart';

class EventsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: [CustomCalendar(),Expanded(child: CustomEventList())],
      
    );
  }
}
