import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:homeapp/Repositories/Models/Contracts/CalendarEntry.dart';

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
    }
  }

  @override
  CalendarState get initialState => CalendarInitial();

  _loadEntries() async {
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
