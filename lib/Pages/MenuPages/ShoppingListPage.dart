import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homeapp/CustomControls/ShoppingList.dart';
import 'package:homeapp/bloc/shopping/shoppingbloc_bloc.dart';

class ShoppingListPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ShoppingBloc>(create: (BuildContext context) {
      return ShoppingBloc()..add(ShoppingListOpened());
    },
    lazy: true,
    child: ShoppingList()
    );
  }
}
