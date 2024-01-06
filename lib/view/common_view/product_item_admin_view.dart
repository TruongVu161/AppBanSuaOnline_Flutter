import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:AppBanSuaOnline_Flutter/view/common_view/product_details_screen.dart';

import '../../main.dart';
import '../../model/product.dart';
import '../../utils/image_path.dart';
import '../../viewmodel/product_viewmodel.dart';
import '../admin/edit_product_screen.dart';

class ProductItemAdminView extends StatefulWidget {
  Product product;

  ProductItemAdminView({required this.product});

  @override
  State<StatefulWidget> createState() => _ProductItemAdminView();
}

class _ProductItemAdminView extends State<ProductItemAdminView> {
  ProductViewModel productViewModel = ProductViewModel();
  void goToProductDetailsScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ProductDetailsScreen(product: widget.product)),
    );
  }

  void goToEditProductScreen() {
    Navigator.push(
      navigationKey.currentContext!,
      MaterialPageRoute(builder: (context) => EditProductScreen(product: widget.product,)),
    );
  }

  showDialogConfirmDeleteProduct() {

    Widget noButton = TextButton(
      child: const Text("Không"),
      onPressed:  () {
        Navigator.of(context).pop();
      },
    );
    Widget yesButton = TextButton(
      child: const Text("Có"),
      onPressed:  () {
        productViewModel.deleteProduct(productId: widget.product.id);
        Navigator.of(context).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      content: const Text("Bạn có chắc muốn xóa sản phẩm này?",textAlign: TextAlign.center),
      actions: [
        noButton,
        yesButton,
      ],
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
        goToProductDetailsScreen();
      },
      child: Card(
        color: Colors.white,
        margin: const EdgeInsets.only(left: 8,right: 8,top: 0,bottom: 8),
        elevation: 16,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Color(0x0D000000), width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        shadowColor: const Color(0x33333333),
        child: Container(
          padding: const EdgeInsets.all(4),
          height: 64,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: productItemImage()),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          widget.product.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.bold)),
                      Text(
                        "${formatCurrency.format(widget.product.price)}",
                        style: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 10,
                            fontStyle: FontStyle.italic),
                      ),
                      Text(
                        "Đăng bởi:${widget.product.uploadBy}",
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 10,
                            fontStyle: FontStyle.italic),
                      ),
                      Text(
                        "Ngày chỉnh sửa:${widget.product.uploadDate}",
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 10,
                            fontStyle: FontStyle.italic),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 36,
                child: TextButton(
                    onPressed: () {
                      goToEditProductScreen();
                    },
                    child: Text(
                      "Sửa",
                      style: TextStyle(
                          fontSize: 10, fontWeight: FontWeight.normal),
                    )),
              ),
              SizedBox(
                width: 36,
                child: TextButton(
                    onPressed: () {
                      showDialogConfirmDeleteProduct();
                    },
                    child: Text(
                      "Xóa",
                      style: TextStyle(fontSize: 10,
                          color: Colors.red,
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

  Widget productItemImage(){
    if(widget.product.image.isNotEmpty){
      return Image.network(
        widget.product.image,
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
    }else{
      return Image.asset(
        ImagePath.imgImageUpload,
        width: 48,
        height: 48,
      );
    }
  }
}
