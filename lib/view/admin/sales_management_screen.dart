import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../model/status.dart';
import '../../viewmodel/order_viewmodel.dart';
import '../common_view/order_item.dart';

class SalesManagementScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SalesManagementScreen();
}

class _SalesManagementScreen extends State<SalesManagementScreen> {
  OrderViewModel orderViewModel = OrderViewModel();
  TextEditingController searchBarController = TextEditingController();
  FocusNode searchBarFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await orderViewModel.getAllOrder();
      orderViewModel.getOrderStream.listen((status) {
        if (status == Status.loading) {
        } else if (status == Status.completed) {
          if(mounted){
            reloadView();
          }
        } else {}
      });
    });
  }

  void reloadView() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: ContainedTabBarView(
            tabBarProperties: const TabBarProperties(
              height: 24,
                indicatorColor: Colors.blueAccent,
                labelStyle: TextStyle(color: Colors.black, fontSize: 12)),
            tabs: const [
              Text('Mới tạo',
                  style: TextStyle(color: Colors.black)),
              Text('Đang xử lý',
                  style: TextStyle(color: Colors.black)),
              Text('Đã giao',
                  style: TextStyle(color: Colors.black))
            ],
            views: [newOrderTab(), processingOrderTab(),doneOrderTab()],
            onChange: (index) => print(index),
          ),
      ),
    );
  }

  Widget newOrderTab() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: orderViewModel.newOrders.length,
            itemBuilder: (context, index) {
              return OrderItem(order: orderViewModel.newOrders[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget processingOrderTab() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: orderViewModel.processingOrders.length,
            itemBuilder: (context, index) {
              return OrderItem(order: orderViewModel.processingOrders[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget doneOrderTab() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: orderViewModel.doneOrders.length,
            itemBuilder: (context, index) {
              return OrderItem(order: orderViewModel.doneOrders[index]);
            },
          ),
        ),
      ],
    );
  }
}
