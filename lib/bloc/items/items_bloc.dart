import 'package:bloc/bloc.dart';
import 'package:flutter_final/bloc/items/item_states.dart';
import 'package:flutter_final/bloc/items/items_events.dart';
import 'package:flutter_final/core/repository/items_repo.dart';
import 'package:flutter_final/model/itemsList.dart';

class ItemsBloc extends Bloc<ItemsEvent, ItemsState> {
  final ItemsRepository itemsRepository;

  ItemsBloc({required this.itemsRepository}) : super(ItemsLoading()) {
    on<FetchItems>((event, emit) async {
      await getItems(emit);
    });
  }

  Future<void> getItems(Emitter<ItemsState> emit) async {
    emit(ItemsLoading());
    try {
      final ItemsList friends = await itemsRepository.getItems();
      emit(ItemsLoaded(items: friends));
    } catch (e) {
      emit(ItemsError(errorMsg: e.toString()));
    }
  }
}
