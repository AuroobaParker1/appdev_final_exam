import 'package:intl/intl.dart';

class Item {
  final String name;
  final String date;
  final String price;
  final String image;

  Item({
    required this.name,
    required this.date,
    required this.price,
    required this.image,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    String currentDate = DateTime.now().toString().substring(0, 10);
    String yesterdayDate =
        DateTime.now().subtract(Duration(days: 1)).toString().substring(0, 10);

    String convertDate(String inputDate) {
      DateTime date = DateTime.parse(inputDate);
      String formattedDate = DateFormat('dd MMM yyyy').format(date);
      return formattedDate;
    }

    var yesterday = yesterdayDate == json['date'];
    var today = currentDate == json['date'];

    return Item(
      name: json['name'] ?? '',
      date: json['date'] == currentDate
          ? 'Today'
          : (json['date'] == yesterdayDate
              ? 'Yesterday'
              : convertDate(json['date']) ?? ''),
      price: json['price'] ?? '',
      image: json['image'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'date': date, 'pric': price, 'image': image};
  }
}
