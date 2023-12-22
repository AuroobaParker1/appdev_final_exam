import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_final/model/itemsList.dart';

class ItemsRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<ItemsList> getItems() async {
    DocumentSnapshot snapshot =
        await _firestore.collection('items').doc('abcd').get();
    return ItemsList.fromJson(snapshot.data() as Map<String, dynamic>);
  }
}
