import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homeapp/CustomControls/CustomCalendar.dart';
import 'package:homeapp/CustomControls/CustomEventList.dart';
import 'package:homeapp/bloc/calendar/calendar_bloc.dart';

class EventsPage extends StatelessWidget {
  CustomCalendar _calendar = CustomCalendar();
  CustomEventList _eventList = CustomEventList();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CalendarBloc>(create: (BuildContext context) => CalendarBloc()..add(CalendarOpened()),
      child: Column(children: [_calendar,Expanded(child: _eventList)],)
      );
  }
}

    
