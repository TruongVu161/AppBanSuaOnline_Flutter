import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
import '../../model/my_order.dart';
import '../../model/order_status.dart';
import '../../utils/common_func.dart';
import '../../utils/image_path.dart';
import '../../viewmodel/order_viewmodel.dart';
import 'details_order_screen.dart';

class OrderItem extends StatefulWidget {
  MyOrder order;

  OrderItem({required this.order});

  @override
  State<StatefulWidget> createState() => _OrderItem();
}

class _OrderItem extends State<OrderItem> {
  OrderViewModel orderViewModel = OrderViewModel();

  void goToOrderDetailsScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => DetailsOrderScreen(order: widget.order)),
    );
  }

  showDialogChangeOrderStatus() {
    Widget newButton = TextButton(
      child: Text("Mới tạo"),
      onPressed: () async {
        await orderViewModel.updateOrderStatus(
            orderId: widget.order.id,
            newStatus: OrderStatus.NEW.toShortString());
        Navigator.of(context).pop();
      },
    );
    Widget processButton = TextButton(
      child: Text("Đang xử lý"),
      onPressed: () async {
        await orderViewModel.updateOrderStatus(
            orderId: widget.order.id,
            newStatus: OrderStatus.PROCESSING.toShortString());
        Navigator.of(context).pop();
      },
    );

    Widget doneButton = TextButton(
      child: Text("Đã xong"),
      onPressed: () async {
        await orderViewModel.updateOrderStatus(
            orderId: widget.order.id,
            newStatus: OrderStatus.DONE.toShortString());
        Navigator.of(context).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      content: Text("Chọn trạng thái?", textAlign: TextAlign.center),
      actions: [newButton, processButton, doneButton],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        goToOrderDetailsScreen();
      },
      child: Card(
        color: Colors.white,
        margin: const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 0),
        elevation: 16,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Color(0x0D000000), width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        shadowColor: const Color(0x33333333),
        child: Container(
          padding: const EdgeInsets.all(4),
          height: 76,
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                  flex: 2,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: productItemImage())),
              Expanded(
                flex: 8,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.order.productName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.bold)),
                      Text(
                        "${formatCurrency.format(widget.order.productPrice)}",
                        style: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 10,
                            fontStyle: FontStyle.italic),
                      ),
                      Text(
                        "Khách hàng:${widget.order.customerName}",
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 10,
                            fontStyle: FontStyle.italic),
                      ),
                      Text(
                        "Ngày tạo:${widget.order.createDate}",
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 10,
                            fontStyle: FontStyle.italic),
                      ),
                      Row(
                        children: [
                          Text(
                            "Trạng thái: ",
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 10,
                                fontStyle: FontStyle.italic),
                          ),
                          Text(
                            CommonFunc.getOrderStatusName(widget.order.status),
                            style: TextStyle(
                                color: CommonFunc.getOrderStatusColor(
                                    widget.order.status),
                                fontSize: 10,
                                fontStyle: FontStyle.italic),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 100,
                child: TextButton(
                    onPressed: () {
                      showDialogChangeOrderStatus();
                    },
                    child: Text(
                      "Đổi trạng thái",
                      style: TextStyle(
                          fontSize: 10,
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.normal),
                    )),
              )
            ],
          ),
          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.white10,
                spreadRadius: 0,
                blurRadius: 12.0,
                offset: Offset(0, 3),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget productItemImage() {
    if (widget.order.productImage.isNotEmpty) {
      return Image.network(
        widget.order.productImage,
        width: 48,
        height: 48,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes!
                  : null,
            ),
          );
        },
      );
    } else {
      return Image.asset(
        ImagePath.imgImageUpload,
        width: 48,
        height: 48,
      );
    }
  }
}
