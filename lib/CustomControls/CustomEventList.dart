import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homeapp/Behaviors/GlowlessBehavior.dart';
import 'package:homeapp/CustomControls/CustomEventElement.dart';
import 'package:homeapp/bloc/calendar/calendar_bloc.dart';

class CustomEventList extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalendarBloc, CalendarState>(builder: (ctx, state) {
      if(state is CalendarLoaded) {
        return ScrollConfiguration(
      behavior: GlowlessBehavior(),
      child: ListView(
        children: [
          CustomEventElement('First Test entry', DateTime.now()),  
        ],
      ),
    );
      } else {
        return Container(width: 0, height: 0,);
      }
      }
    );
    
  }
}
