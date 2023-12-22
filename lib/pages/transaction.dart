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
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              item.image,
              fit: BoxFit.cover,
              width: 50,
              height: 50,
            ),
          ),
          title: Text(
            item.name,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(item.date),
          trailing: Text(
            item.price,
            style: TextStyle(
              color: item.price.startsWith('-') ? Colors.red : Colors.blue,
              fontSize: 20,
            ),
          ),
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  state.items.day.toUpperCase(),
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.grey),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  state.items.date,
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 30),
                              ],
                            ),
                          )
                        ]),
                        Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              state.items.total,
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                            ))
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
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 19,
                            blurRadius: 8,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: ListView.builder(
                        itemCount: state.items.items.length + 1,
                        itemBuilder: (_, int index) {
                          if (index == 0) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                  top: 40, left: 40, right: 40),
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
