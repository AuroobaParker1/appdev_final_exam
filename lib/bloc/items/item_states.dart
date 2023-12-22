import 'package:flutter_final/model/itemsList.dart';

abstract class ItemsState {
  const ItemsState([List props = const []]) : super();
}

class ItemsEmpty extends ItemsState {}

class ItemsLoading extends ItemsState {}

class ItemsLoaded extends ItemsState {
  final ItemsList items;

  ItemsLoaded({required this.items}) : super([items]);
}

class ItemsError extends ItemsState {
  final String? errorMsg;
  ItemsError({this.errorMsg});
}
