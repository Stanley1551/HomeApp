import 'package:flutter/material.dart';
import 'package:homeapp/CustomControls/CustomDrawer.dart';
import 'package:homeapp/Repositories/AuthRepository.dart';

class HomePage extends StatelessWidget {
  final AuthRepository repo;

  HomePage(this.repo);

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
