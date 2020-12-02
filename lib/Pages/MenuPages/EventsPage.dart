import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class EventsPage extends StatefulWidget {
  @override
  _EventsPageState createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  var _calendarController;
  @override
void initState() {
  super.initState();
  _calendarController = CalendarController();
  
}

@override
void dispose() {
  _calendarController.dispose();
  super.dispose();
}

@override
Widget build(BuildContext context) {
  return TableCalendar(startingDayOfWeek: StartingDayOfWeek.monday,
    calendarController: _calendarController,
  );
}
}
