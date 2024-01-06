import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../model/my_order.dart';
import '../../../utils/common_func.dart';
import 'order_repo.dart';

class OrderRepoImpl with OrderRepo {
  @override
  Future<bool> createOrder({required MyOrder order}) async {
    try {
      Map<String, dynamic> orderMap = {
        "id": order.id,
        "product_image": order.productImage,
        "product_name": order.productName,
        "product_price": order.productPrice,
        "customer_name": order.customerName,
        "customer_email": order.customerEmail,
        "phone_number": order.phoneNumber,
        "address": order.address,
        "status": order.status,
        "create_date": order.createDate,
        "update_date": order.updateDate,
      };

      await FirebaseFirestore.instance
          .collection('ORDERS')
          .doc(order.id)
          .set(orderMap)
          .then((value) {})
          .catchError((error) {
        CommonFunc.showToast("Lỗi gửi yêu cầu.");
        print("error:${error.toString()}");
        return Future.value(false);
      });
      return Future.value(true);
    } on FirebaseException catch (e) {
      CommonFunc.showToast("Đã có lỗi xảy ra.");
    } catch (e) {
      CommonFunc.showToast("Đã có lỗi xảy ra.");
    }
    return Future.value(false);
  }

  @override
  Future<List<MyOrder>> getAllOrder() async {
    List<MyOrder> orders = [];

    try {
      await FirebaseFirestore.instance.collection("ORDERS").get().then((querySnapshot) {
        for (var result in querySnapshot.docs) {
          orders.add(MyOrder.fromJson(result.data()));
        }
        print("order length:${orders.length}");
      });
      return orders;
    } catch (error) {
      print("error:${error.toString()}");
    }

    return [];
  }

  @override
  Future<bool> updateOrder({required String orderId, required String newStatus}) {
    try {
      //Update order status
      Map<String, dynamic> orderMap = {
        "status": newStatus,
      };

      FirebaseFirestore.instance.collection('ORDERS').doc(orderId).update(orderMap);
      return Future.value(true);
    } on FirebaseException catch (e) {
      CommonFunc.showToast("Đã có lỗi xảy ra.");
    } catch (e) {
      CommonFunc.showToast("Đã có lỗi xảy ra.");
    }
    return Future.value(false);
  }
}
