import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
import '../../model/product.dart';
import '../../utils/common_func.dart';
import '../../utils/image_path.dart';
import '../../viewmodel/auth_viewmodel.dart';

class ProductDetailsScreen extends StatefulWidget {
  Product product;

  ProductDetailsScreen({required this.product});

  @override
  State<StatefulWidget> createState() => _ProductDetailsScreen();
}

class _ProductDetailsScreen extends State<ProductDetailsScreen> {
  AuthViewModel authViewModel = AuthViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Chi tiết sản phẩm",
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.grey,
              size: 24,
            )),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: ClipRRect(borderRadius: BorderRadius.circular(10), child: productItemImage()),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(widget.product.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
              const Divider(
                thickness: 0.5,
                color: Colors.green,
                height: 16,
              ),
              Center(
                child: Text(
                    "${formatCurrency.format(widget.product.price)}",
                  style: TextStyle(color: Colors.redAccent, fontSize: 20, fontStyle: FontStyle.italic),
                ),
              ),
              Center(
                child: Text(
                  "Thể loại: ${CommonFunc.getSenDaNameByType(widget.product.type)}",
                  style: TextStyle(color: Colors.black, fontSize: 14, fontStyle: FontStyle.italic),
                ),
              ),
              const Divider(
                thickness: 0.5,
                color: Colors.green,
                height: 16,
              ),
              const Text(
                "Mô tả",
                style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const Padding(padding: EdgeInsets.only(top: 8)),
              Text(
                widget.product.description,
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 15,
                ),
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
        widget.product.image,
        width: 76,
        height: 76,
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
        width: 76,
        height: 76,
      );
    }
  }
}
