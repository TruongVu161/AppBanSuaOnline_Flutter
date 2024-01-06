import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../utils/common_func.dart';
import '../../../utils/image_path.dart';
import '../../main.dart';
import '../../model/my_order.dart';
import '../../viewmodel/order_viewmodel.dart';

class DetailsOrderScreen extends StatefulWidget {
  MyOrder order;

  DetailsOrderScreen({Key? key, required this.order}) : super(key: key);

  @override
  State<DetailsOrderScreen> createState() => _DetailsOrderScreenState();
}

class _DetailsOrderScreenState extends State<DetailsOrderScreen> {
  OrderViewModel orderViewModel = OrderViewModel();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      reloadView();
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
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            centerTitle: true,
            title: const Text(
              "Chi tiết hoá đơn",
              style: TextStyle(color: Colors.black),
            ),
            leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.grey,
                  size: 20,
                )),
            elevation: 0,
          ),
          body: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Thông tin đơn hàng",
                    style: TextStyle(color: Colors.black, fontSize: 14),
                  ),
                  const Divider(
                    thickness: 0.5,
                    color: Colors.grey,
                    height: 16,
                  ),
                  orderDetail(),
                  const Padding(padding: EdgeInsets.only(top: 24)),
                  Text(
                    "Thông tin liên hệ",
                    style: TextStyle(color: Colors.black, fontSize: 14),
                  ),
                  const Divider(
                    thickness: 0.5,
                    color: Colors.grey,
                    height: 16,
                  ),
                  contactInfo(),
                ],
              ),
            ),
          )),
    );
  }

  Widget orderDetail() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: ClipRRect(borderRadius: BorderRadius.circular(10), child: productItemImage()),
        ),
        Text("Tên sản phẩm: ${widget.order.productName}",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.black,
              fontSize: 12,
            )),
        Text(
          "${formatCurrency.format(widget.order.productPrice)}",
          style: const TextStyle(color: Colors.redAccent, fontSize: 12, fontStyle: FontStyle.italic),
        ),
        Text(
          "Trạng thái: ${CommonFunc.getOrderStatusName(widget.order.status)}",
          style: const TextStyle(color: Colors.black, fontSize: 12, fontStyle: FontStyle.italic),
        ),
      ],
    );
  }

  Widget contactInfo() {
    return Container(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: Column(
        children: [
          const Padding(padding: EdgeInsets.only(top: 16)),
          Row(
            children: [
              const Text(
                "Khách hàng: ",
                style: TextStyle(color: Colors.black, fontSize: 12, fontStyle: FontStyle.italic),
              ),
              Text(
                widget.order.customerName,
                style: const TextStyle(color: Colors.blueAccent, fontSize: 12, fontStyle: FontStyle.italic),
              ),
            ],
          ),
          const Padding(padding: EdgeInsets.only(top: 16)),
          Row(
            children: [
              const Text(
                "Email: ",
                style: TextStyle(color: Colors.black, fontSize: 12, fontStyle: FontStyle.italic),
              ),
              Text(
                widget.order.customerEmail,
                style: const TextStyle(color: Colors.blueAccent, fontSize: 12, fontStyle: FontStyle.italic),
              ),
            ],
          ),
          const Padding(padding: EdgeInsets.only(top: 16)),
          Row(
            children: [
              const Text(
                "Số điện thoại: ",
                style: TextStyle(color: Colors.black, fontSize: 12, fontStyle: FontStyle.italic),
              ),
              Text(
                widget.order.phoneNumber,
                style: const TextStyle(color: Colors.blueAccent, fontSize: 12, fontStyle: FontStyle.italic),
              ),
            ],
          ),
          const Padding(padding: EdgeInsets.only(top: 16)),
          Row(
            children: [
              const Text(
                "Địa chỉ: ",
                style: TextStyle(color: Colors.black, fontSize: 12, fontStyle: FontStyle.italic),
              ),
              Text(
                widget.order.address,
                style: const TextStyle(color: Colors.blueAccent, fontSize: 12, fontStyle: FontStyle.italic),
              ),
            ],
          ),
          const Padding(padding: EdgeInsets.only(top: 32)),
        ],
      ),
    );
  }

  Widget productItemImage() {
    if (widget.order.productImage.isNotEmpty) {
      return Image.network(
        height: 100,
        width: 100,
        widget.order.productImage,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                  : null,
            ),
          );
        },
      );
    } else {
      return Image.asset(
        ImagePath.imgImageUpload,
        height: 76,
        width: 76,
      );
    }
  }
}
