import 'package:flutter/material.dart';
import 'package:homeapp/CustomControls/CustomLanguagePicker.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomLanguagePicker(),
    );
  }
}