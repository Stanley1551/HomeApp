import 'package:flutter/material.dart';
import 'package:homeapp/CustomControls/CustomDrawer.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Text('Welcome Home'),
      ),
      body: Center(
        child: Text(
          'Placeholder for dashboard',
        ),
      ),
    );
  }
}
