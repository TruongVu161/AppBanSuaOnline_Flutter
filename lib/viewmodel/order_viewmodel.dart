import 'dart:async';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:rxdart/rxdart.dart';

import '../base/baseviewmodel/base_viewmodel.dart';
import '../data/repositories/order_repo/order_repo.dart';
import '../data/repositories/order_repo/order_repo_impl.dart';
import '../model/my_order.dart';
import '../model/order_status.dart';
import '../model/status.dart';
import '../utils/common_func.dart';
import 'notification_viewmodel.dart';

class OrderViewModel extends BaseViewModel {
  static final OrderViewModel _instance = OrderViewModel._internal();

  factory OrderViewModel() {
    return _instance;
  }

  OrderViewModel._internal();

  OrderRepo orderRepo = OrderRepoImpl();

  List<MyOrder> orders = [];
  List<MyOrder> newOrders = [];
  List<MyOrder> processingOrders = [];
  List<MyOrder> doneOrders = [];

  final StreamController<Status> getOrderController = BehaviorSubject<Status>();

  Stream<Status> get getOrderStream => getOrderController.stream;

  @override
  FutureOr<void> init() {}

  Future<void> getAllOrder() async {
    orders.clear();
    getOrderController.sink.add(Status.loading);
    EasyLoading.show();
    orderRepo.getAllOrder().then((value) {
      if (value.isNotEmpty) {
        orders = value;
        //filter product by type
        filterOrderByType();
        notifyListeners();
        getOrderController.sink.add(Status.completed);
      }
      EasyLoading.dismiss();
    }).onError((error, stackTrace) {
      getOrderController.sink.add(Status.error);
      EasyLoading.dismiss();
    });
  }

  Future<void> createOrder({required MyOrder order}) async {
    orderRepo.createOrder(order: order).then((value) async {
      if (value == true) {
        CommonFunc.showToast("Gửi yêu cầu thành công.");
        NotificationViewModel().newOrderNotification();
      }
    }).onError((error, stackTrace) {
      print("create order fail");
    });
  }

  Future<void> updateOrderStatus({required String orderId, required String newStatus}) async {
    await orderRepo.updateOrder(orderId: orderId, newStatus: newStatus).then((value) async {
      if (value == true) {
        CommonFunc.showToast("Cập nhật thành công.");
        await getAllOrder();
      }
    }).onError((error, stackTrace) {
      print("update fail");
    });
  }

  //
  // void deleteProduct({required String productId}) {
  //   orderRepo.deleteProduct(productId: productId).then((value) {
  //     if (value == true) {
  //       print("add success");
  //       CommonFunc.showToast("Xóa thành công.");
  //       //reload product
  //       getAllProduct();
  //     }
  //   }).onError((error, stackTrace) {
  //     print("add fail");
  //   });
  // }

  void clearAllList() {
    newOrders.clear();
    processingOrders.clear();
    doneOrders.clear();
  }

  void filterOrderByType() {
    //clear all list
    clearAllList();

    //filter
    for (var element in orders) {
      if (element.status == OrderStatus.NEW.toShortString()) {
        newOrders.add(element);
      } else if (element.status == OrderStatus.PROCESSING.toShortString()) {
        processingOrders.add(element);
      } else if (element.status == OrderStatus.DONE.toShortString()) {
        doneOrders.add(element);
      }
    }
  }
}
