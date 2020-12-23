import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homeapp/Behaviors/GlowlessBehavior.dart';
import 'package:homeapp/CustomControls/CustomEventElement.dart';
import 'package:homeapp/Repositories/Models/Contracts/CalendarEntry.dart';
import 'package:homeapp/bloc/calendar/calendar_bloc.dart';

class CustomEventList extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalendarBloc, CalendarState>(builder: (ctx, state) {
      if(state is CalendarLoaded || state is CalendarDaySelected) {
        return ScrollConfiguration(
      behavior: GlowlessBehavior(),
      child: ListView(
        children: state is CalendarLoaded ? _getEventList(events: state.events)
          : state is CalendarDaySelected ? _getEventList(filteredList: state.filteredEvents) : Container()
      ),
    );
      } else {
        return Container(width: 0, height: 0,);
      }
      }
    );
    
  }

  List<Widget> _getEventList({Map<DateTime,
    List<CalendarEntry>> events, List<CalendarEntry> filteredList}){
      List<Widget> retVal;
      if(events != null && events.isNotEmpty){
        retVal = _convertEventListToWidget(events[DateTime.now()]);
      }
      else if(filteredList != null && filteredList.length > 0){
        retVal = _convertEventListToWidget(filteredList);
      }
      if(retVal == null || retVal.length == 0)
      {
        retVal = new List<Widget>();
        retVal.add(Container());
      }
      return retVal;
  }

  List<CustomEventElement> _convertEventListToWidget(List<CalendarEntry> list){
    if(list != null && list.length > 0)
    return list.map<CustomEventElement>((e) {return CustomEventElement(e.title, e.date);}).toList();
    return null;
  }
}
