import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homeapp/bloc/shopping/shoppingbloc_bloc.dart';

class ShoppingList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShoppingBloc,ShoppingblocState>(builder: (ctx, state){
      if(state is ShoppingblocInitial){
        return LinearProgressIndicator();
      } else if(state is ShoppingListLoaded){
        var map = BlocProvider.of<ShoppingBloc>(ctx).shoppingList;
        return ListView(
          children: constructCheckboxList(map),
    );
      } else return LinearProgressIndicator();
    },
    );
    
  }

  List<CheckboxListTile> constructCheckboxList(Map<String,bool> map){
    return map.entries.map<CheckboxListTile>((entry) {
      return CheckboxListTile(
        title: Text(entry.key),
        onChanged:(val) {},
        value: entry.value
      );
    }
      ).toList();
  }
}