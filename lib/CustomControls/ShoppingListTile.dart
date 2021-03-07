import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homeapp/bloc/shopping/shoppingbloc_bloc.dart';

class ShoppingListTile extends StatelessWidget  {
  final String title;
  ShoppingListTile(this.title);

  @override
  Widget build(BuildContext context) {
    bool isChecked = BlocProvider.of<ShoppingBloc>(context).shoppingList[this.title];
    return CheckboxListTile(
        title: Text(this.title, style:
        isChecked ?
        TextStyle(color: Colors.grey,decoration: TextDecoration.lineThrough)
        :
        TextStyle(color: Colors.white), ),
        onChanged:(val) {
          BlocProvider.of<ShoppingBloc>(context).add(ShoppingElementChange(this.title, val));
        },
        value: isChecked,
        checkColor: Colors.black,
        activeColor: Colors.blue,
      );
  }
}