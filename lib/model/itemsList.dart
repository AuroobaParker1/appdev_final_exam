import 'package:flutter_final/model/item.dart';

class ItemsList {
  final List<dynamic> items;
  final String day;
  final String date;
  final String total;

  ItemsList({
    required this.day,
    required this.date,
    required this.items,
    required this.total,
  });

  factory ItemsList.fromJson(Map<String, dynamic> json) {
    return ItemsList(
        total: json['total'] ?? '',
        day: json['day'] ?? '',
        date: json['date'],
        items: json['items']
            .map((item) => Item.fromJson(item as Map<String, dynamic>))
            .toList());
  }
}
