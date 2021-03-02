import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'shoppingbloc_event.dart';
part 'shoppingbloc_state.dart';

class ShoppingBloc extends Bloc<ShoppingblocEvent, ShoppingblocState> {
  ShoppingBloc();
  Map<String, bool> shoppingList = new Map<String, bool>();

  @override
  Stream<ShoppingblocState> mapEventToState(
    ShoppingblocEvent event,
  ) async* {
    if(event is ShoppingListOpened){
      yield ShoppingblocInitial();
      await _loadEntries();
      yield ShoppingListLoaded();
    }
  }

  @override
  ShoppingblocState get initialState => ShoppingblocInitial();

  Future<void> _loadEntries() async {
    if(shoppingList.isEmpty){
      var snapshot = await FirebaseFirestore.instance.collection('shoppinglist').get();
      var doc = snapshot.docs.first; //hopefully, always the most recent
      List list = doc.data().values.first;
      shoppingList.addEntries(list.map((e) => MapEntry(e.toString(),false)));
    }
  }
}
