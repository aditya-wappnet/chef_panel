import 'package:chef_panel/models/order_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  // services

/*   Stream<List<OrderModel>> getOrders() {
    return _db.collection("orders").snapshots().map((snapshot) => snapshot.docs
        .map((document) => OrderModel.fromMap(document.data()))
        .toList());
  } */
  /* Stream<List<OrderModel>> getOrders() {
    // fetchMenuIds1();
    return FirebaseFirestore.instance.collectionGroup('orders').snapshots().map(
        (snapshot) => snapshot.docs
            .map((document) => OrderModel.fromMap(document.data()))
            .toList());
  } */
  Stream<List<OrderModel>> getOrders() {
    // fetchMenuIds1();
    return FirebaseFirestore.instance
        .collectionGroup('orders')
        .where('orderStatus', isEqualTo: 'ordered')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((document) => OrderModel.fromMap(document.data()))
            .toList());
  }
}
