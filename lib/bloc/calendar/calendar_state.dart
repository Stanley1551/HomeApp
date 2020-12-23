part of 'calendar_bloc.dart';

abstract class CalendarState extends Equatable {
  final Map<DateTime, List<CalendarEntry>> events;
  const CalendarState(this.events);
  
  @override
  List<Object> get props => [];
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
