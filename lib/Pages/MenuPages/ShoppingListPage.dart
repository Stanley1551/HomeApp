import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homeapp/CustomControls/ShoppingList.dart';
import 'package:homeapp/bloc/shopping/shoppingbloc_bloc.dart';

class ShoppingListPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ShoppingBloc>(context).add(ShoppingListOpened());
    return ShoppingList();
  }
}
