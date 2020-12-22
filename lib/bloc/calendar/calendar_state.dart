part of 'calendar_bloc.dart';

abstract class CalendarState extends Equatable {
  const CalendarState();
  
  @override
  List<Object> get props => [];
}

class CalendarInitial extends CalendarState {}

class CalendarLoaded extends CalendarState {
  final Map<DateTime, List<CalendarEntry>> events;
  CalendarLoaded(this.events);
}
