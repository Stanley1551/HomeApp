import 'package:flutter/material.dart';
import 'package:homeapp/Behaviors/GlowlessBehavior.dart';
import 'package:homeapp/CustomControls/CustomEventElement.dart';

class CustomEventList extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: GlowlessBehavior(),
      child: ListView(
        children: [
          CustomEventElement('First Test entry', DateTime.now()),  
        ],
      ),
    );
  }
}
