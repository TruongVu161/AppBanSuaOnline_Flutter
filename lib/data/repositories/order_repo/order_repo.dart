

import '../../../model/my_order.dart';

abstract class OrderRepo {
  Future<List<MyOrder>> getAllOrder();
  Future<bool> createOrder({required MyOrder order});
  Future<bool> updateOrder({required String orderId, required String newStatus});
  // Future<bool> deleteOrder({required String productId});
}