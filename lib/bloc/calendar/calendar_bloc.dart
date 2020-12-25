import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homeapp/Repositories/Models/Contracts/CalendarEntry.dart';
import 'package:homeapp/bloc/Authentication/authentication_bloc.dart';

part 'calendar_event.dart';
part 'calendar_state.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  Map<DateTime, List<CalendarEntry>> events = Map<DateTime, List<CalendarEntry>>();
  CalendarBloc();

  @override
  Stream<CalendarState> mapEventToState(
    CalendarEvent event,
  ) async* {
    if(event is CalendarOpened){
      yield CalendarInitial();
      await _loadEntries();
      yield CalendarLoaded(events);
    } else if(event is CalendarDayTapped){
      List<CalendarEntry> filteredEvents = new List<CalendarEntry>();
      this.events.forEach((key, value) {if(key.day == event.daySelected.day && 
      key.month == event.daySelected.month && key.year == event.daySelected.year){
        filteredEvents =  value;
      }});
      yield CalendarDaySelected(events, filteredEvents);
    }
    else if(event is CalendarEventAdded){
      var data = CalendarEntry(event.eventTime,event.title,null).toMap();
      await FirebaseFirestore.instance.collection('events').add(data);
      //client side lie, or this...
      await _loadEntries();
      yield CalendarLoaded(events);
    }
  }

  @override
  CalendarState get initialState => CalendarInitial();

  _loadEntries() async {
    events.clear();
    var snapshot = await FirebaseFirestore.instance.collection('events').get();
      for (var doc in snapshot.docs) {
      if(events[DateTime.fromMicrosecondsSinceEpoch(doc.data()['date'].millisecondsSinceEpoch*1000)] == null){
        events[DateTime.fromMicrosecondsSinceEpoch(doc.data()['date'].millisecondsSinceEpoch*1000)] = new List<CalendarEntry>();
      }
      events[DateTime.fromMicrosecondsSinceEpoch(doc.data()['date'].millisecondsSinceEpoch*1000)].add(CalendarEntry(
          DateTime.fromMicrosecondsSinceEpoch(doc.data()['date'].millisecondsSinceEpoch*1000), doc.data()['title'], doc.data()['userid']));
    }
  }
}
