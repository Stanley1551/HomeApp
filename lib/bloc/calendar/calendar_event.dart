part of 'calendar_bloc.dart';

abstract class CalendarEvent {
  const CalendarEvent();
}

class CalendarOpened extends CalendarEvent{}

class CalendarDayTapped extends CalendarEvent {
  final DateTime daySelected;
  CalendarDayTapped(this.daySelected);
}
