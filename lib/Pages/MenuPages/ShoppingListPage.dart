import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homeapp/CustomControls/ShoppingList.dart';
import 'package:homeapp/bloc/shopping/shoppingbloc_bloc.dart';

class ShoppingListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ShoppingBloc>(context).add(ShoppingListOpened());
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Row(
            children: [
              ElevatedButton(
                onPressed: () {},
                child: Row(
                  children: [
                    Icon(Icons.edit),
                    Text(
                      'Modify',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 19,
                          fontWeight: FontWeight.w300),
                    )
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                child: Row(
                  children: [
                    Icon(Icons.done),
                    Text(
                      'Complete',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 19,
                          fontWeight: FontWeight.w300),
                    )
                  ],
                ),
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          ),
        ),
        Divider(color: Colors.blue),
        Expanded(child: ShoppingList()),
      ],
    );
  }
}
