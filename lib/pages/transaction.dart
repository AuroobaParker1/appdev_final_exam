import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_final/bloc/items/item_states.dart';
import 'package:flutter_final/bloc/items/items_bloc.dart';
import 'package:flutter_final/bloc/items/items_events.dart';
import 'package:flutter_final/core/repository/items_repo.dart';
import 'package:flutter_final/model/item.dart';

class TransactionsList extends StatefulWidget {
  const TransactionsList({Key? key}) : super(key: key);

  @override
  _TransactionsListState createState() => _TransactionsListState();
}

class _TransactionsListState extends State<TransactionsList> {
  final ItemsRepository itemsRepository = ItemsRepository();
  late ItemsBloc _itemsBloc;

  Widget buildItemsBottomSheet(Item item) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(item.image),
            radius: 25,
          ),
          title: Text(item.name),
          subtitle: Text(item.date),
          trailing: Text(item.price),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _itemsBloc = ItemsBloc(itemsRepository: itemsRepository);
    _itemsBloc.add(const FetchItems());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {},
          ),
          backgroundColor: Colors.white,
          actions: [
            IconButton(
              icon: const Icon(Icons.more_horiz),
              onPressed: () {},
            )
          ],
        ),
        body: BlocBuilder(
            bloc: _itemsBloc,
            builder: (_, ItemsState state) {
              if (state is ItemsEmpty) {
                return const Center(child: Text('Empty state'));
              }
              if (state is ItemsLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is ItemsLoaded) {
                return Scaffold(
                    body: Column(children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  state.items.day,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  state.items.date,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          )
                        ]),
                        Text(state.items.total)
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: ListView.builder(
                        itemCount: state.items.items.length + 1,
                        itemBuilder: (_, int index) {
                          if (index == 0) {
                            return Padding(
                              padding: const EdgeInsets.all(40),
                              child: Text(
                                'Transactions',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            );
                          } else {
                            return buildItemsBottomSheet(
                                state.items.items[index - 1]);
                          }
                        },
                      ),
                    ),
                  )
                ]));
              }

              if (state is ItemsError) {
                return Center(child: Text(state.errorMsg!));
              }
              return const Center();
            }));
  }

  @override
  void dispose() {
    _itemsBloc.close();
    super.dispose();
  }
}
