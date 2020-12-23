import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homeapp/Repositories/Models/Contracts/CalendarEntry.dart';
import 'package:homeapp/bloc/calendar/calendar_bloc.dart';
import 'package:table_calendar/table_calendar.dart';

class CustomCalendar extends StatefulWidget {
  Map<DateTime, List<CalendarEntry>> events = new Map<DateTime,List<CalendarEntry>>();
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
    return BlocBuilder<CalendarBloc, CalendarState>(builder: (ctx, state) {
      if(state is CalendarLoaded || state is CalendarDaySelected) {
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
      events: state.events,
      headerStyle: HeaderStyle(),
      onDaySelected: (day, events, holidays) {
        BlocProvider.of<CalendarBloc>(context).add(CalendarDayTapped(day));
      },
    );
      } else {
        return Center(child: LinearProgressIndicator());
      }
      }
    );
    
  }
}
