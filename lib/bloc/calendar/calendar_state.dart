part of 'calendar_bloc.dart';

abstract class CalendarState {
  final Map<DateTime, List<CalendarEntry>> events;
  const CalendarState(this.events);
}

class CalendarInitial extends CalendarState {
  CalendarInitial():super(null);
}

class CalendarLoaded extends CalendarState {
  CalendarLoaded(events):super (events);
}

class CalendarDaySelected extends CalendarState {
  final List<CalendarEntry> filteredEvents;

  CalendarDaySelected(events, this.filteredEvents): super(events);
}
