import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homeapp/Behaviors/GlowlessBehavior.dart';
import 'package:homeapp/CustomControls/ShoppingListTile.dart';
import 'package:homeapp/bloc/shopping/shoppingbloc_bloc.dart';

class ShoppingList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShoppingBloc, ShoppingblocState>(
      builder: (ctx, state) {
        if (state is ShoppingblocInitial) {
          return LinearProgressIndicator();
        } else if (state is ShoppingListLoaded) {
          var map = BlocProvider.of<ShoppingBloc>(ctx).shoppingList;
          return ScrollConfiguration(
              behavior: GlowlessBehavior(),
              child: ListView(
                children: constructCheckboxList(map),
              ));
        } else
          return LinearProgressIndicator();
      },
    );
  }

  List<ShoppingListTile> constructCheckboxList(Map<String, bool> map) {
    return map.entries.map<ShoppingListTile>((entry) {
      return ShoppingListTile(entry.key);
    }).toList();
  }
}
