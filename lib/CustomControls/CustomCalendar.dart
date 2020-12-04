import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CustomCalendar extends StatefulWidget {
  @override
  _CustomCalendarState createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
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
    availableCalendarFormats: const {CalendarFormat.month:'2 weeks', CalendarFormat.twoWeeks: 'Month', }, //really?
    calendarStyle: CalendarStyle(selectedColor: Colors.blue, todayColor: Colors.grey, ),
    //TODO integrate: events: ,
    headerStyle: HeaderStyle(),
  );
}
}