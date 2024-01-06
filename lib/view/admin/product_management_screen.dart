import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../model/product.dart';
import '../../../model/status.dart';
import '../../main.dart';
import '../../viewmodel/product_viewmodel.dart';
import '../common_view/product_item_admin_view.dart';
import 'add_product_screen.dart';

class ProductManagementScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ProductManagementScreen();
}

class _ProductManagementScreen extends State<ProductManagementScreen> {
  ProductViewModel productViewModel = ProductViewModel();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await productViewModel.getAllProduct();
      productViewModel.getProductStream.listen((status) {
        if (status == Status.loading) {
        } else if (status == Status.completed) {
          if (mounted) {
            reloadView();
          }
        } else {}
      });
    });
  }

  void reloadView() {
    setState(() {});
  }

  static void goToAddProductScreen() {
    Navigator.push(
      navigationKey.currentContext!,
      MaterialPageRoute(builder: (context) => AddProductScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
                child: productViewModel.products.isNotEmpty
                    ? allProduct(productViewModel.products)
                    : const Center(
                        child: Text("Không có sản phẩm."),
                      ),
              ),
            )
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: SizedBox(
          width: 36,
          height: 36,
          child: FloatingActionButton(
            child: const Icon(Icons.add),
            backgroundColor: Colors.green,
            onPressed: () {
              goToAddProductScreen();
            },
          ),
        ),
      ),
    );
  }

  Widget allProduct(List<Product> sendas) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemCount: productViewModel.products.length,
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) {
        return ProductItemAdminView(product: productViewModel.products[index]);
      },
    );
  }
}
