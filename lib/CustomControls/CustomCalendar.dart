import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:homeapp/Repositories/Models/Contracts/CalendarEntry.dart';
import 'package:table_calendar/table_calendar.dart';

class CustomCalendar extends StatefulWidget {
  Map<DateTime, List<CalendarEntry>> _events = new Map<DateTime,List<CalendarEntry>>();
  @override
  _CustomCalendarState createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
  var _calendarController;
  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
    FirebaseFirestore.instance.collection('events').get().then((snapshot) {
      for (var doc in snapshot.docs) {
      if(this.widget._events[DateTime.fromMicrosecondsSinceEpoch(doc.data()['date'].millisecondsSinceEpoch*1000)] == null){
        this.widget._events[DateTime.fromMicrosecondsSinceEpoch(doc.data()['date'].millisecondsSinceEpoch*1000)] = new List<CalendarEntry>();
      }
      this.widget._events[DateTime.fromMicrosecondsSinceEpoch(doc.data()['date'].millisecondsSinceEpoch*1000)].add(CalendarEntry(
          DateTime.fromMicrosecondsSinceEpoch(doc.data()['date'].millisecondsSinceEpoch*1000), doc.data()['title'], doc.data()['userid']));
    }
    });
    
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      startingDayOfWeek: StartingDayOfWeek.monday,
      calendarController: _calendarController,
      availableCalendarFormats: const {
        CalendarFormat.month: '2 weeks',
        CalendarFormat.twoWeeks: 'Month',
      }, //really?
      calendarStyle: CalendarStyle(
        selectedColor: Colors.blue,
        todayColor: Colors.grey,
      ),
      events: this.widget._events,
      headerStyle: HeaderStyle(),
    );
  }
}
