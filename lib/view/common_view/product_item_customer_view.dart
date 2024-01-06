import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:AppBanSuaOnline_Flutter/view/common_view/product_details_screen.dart';

import '../../main.dart';
import '../../model/product.dart';
import '../../utils/image_path.dart';
import '../customer/order/confirm_order_screen.dart';
import 'custom_button_buy_now.dart';

class ProductItemCustomerView extends StatefulWidget {
  Product product;

  ProductItemCustomerView({required this.product});

  @override
  State<StatefulWidget> createState() => _ProductItemCustomerView();
}

class _ProductItemCustomerView extends State<ProductItemCustomerView> {
  void goToProductDetailsScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProductDetailsScreen(product: widget.product)),
    );
  }

  void goToConfirmOrderScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ConfirmOrderScreen(product: widget.product)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        goToProductDetailsScreen();
      },
      child: Card(
        color: Colors.white,
        margin: const EdgeInsets.only(top: 12, left: 8, right: 8, bottom: 12),
        elevation: 16,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Color(0x0D000000), width: 1),
          borderRadius: BorderRadius.circular(16),
        ),
        shadowColor: const Color(0x33333333),
        child: Container(
          width: 120,
          padding: const EdgeInsets.only(top: 0, left: 2, right: 2, bottom: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(borderRadius: BorderRadius.circular(10), child: productItemImage()),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(widget.product.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold)),
              ),
              Text(
                "${formatCurrency.format(widget.product.price)}",
                style: TextStyle(color: Colors.redAccent, fontSize: 14, fontStyle: FontStyle.italic),
              ),
              Spacer(),
              CustomButtonCreateOrder(
                  onClick: () {
                    goToConfirmOrderScreen();
                  },
                  title: "Đặt hàng",
                  bgColor: Colors.white,
                  borderColor: Colors.blue,
                  textStyle: TextStyle(color: Colors.blue, fontSize: 12))
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
    if (widget.product.image.isNotEmpty) {
      return Image.network(
        height: 120,
        widget.product.image,
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
        height: 120,
      );
    }
  }
}
