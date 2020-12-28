import 'package:flutter/material.dart';
import 'package:homeapp/Services/AppLocalization.dart';

class ShoppingListPage extends StatefulWidget {
  @override
  _ShoppingListPageState createState() => _ShoppingListPageState();
}

class _ShoppingListPageState extends State<ShoppingListPage> {
  void initState() {
    super.initState();
        AppLocalization.load(Locale('hu','HU'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text(AppLocalization.of(context).shoppingList,),),
      
    );
  }
}
