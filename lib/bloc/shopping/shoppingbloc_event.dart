part of 'shoppingbloc_bloc.dart';

abstract class ShoppingblocEvent {
  ShoppingblocEvent();
}

class ShoppingListOpened extends ShoppingblocEvent {}

class ShoppingElementChange extends ShoppingblocEvent {
  final String key;
  final bool change;
  ShoppingElementChange(this.key,this.change);
}
