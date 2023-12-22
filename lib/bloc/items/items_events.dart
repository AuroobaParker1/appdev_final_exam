import 'package:equatable/equatable.dart';

abstract class ItemsEvent extends Equatable {
  const ItemsEvent([List props = const []]) : super();
}

class FetchItems extends ItemsEvent {
  const FetchItems() : super();

  @override
  List<Object?> get props => throw UnimplementedError();
}
