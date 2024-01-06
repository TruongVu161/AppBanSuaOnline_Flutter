import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../model/product.dart';
import '../../../model/status.dart';
import '../../../utils/common_func.dart';
import '../../../viewmodel/product_viewmodel.dart';
import '../../common_view/product_item_customer_view.dart';

class CustomerHomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CustomerHomeScreen();
}

class _CustomerHomeScreen extends State<CustomerHomeScreen> {
  ProductViewModel productViewModel = ProductViewModel();
  TextEditingController searchBarController = TextEditingController();
  FocusNode searchBarFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      productViewModel.getAllProduct();
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.only(
              left: 0,
              top: MediaQuery.of(context).padding.bottom + 16,
              right: 0,
              bottom: MediaQuery.of(context).padding.bottom + 8),
          child: Container(
            color: Colors.white,
            height: MediaQuery.of(context).size.height * 2,
            padding: EdgeInsets.only(top: 48),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize : MainAxisSize.max,
              children: [
                Row(
                  children: [
                    // Expanded(
                    //   child: Padding(
                    //     padding: const EdgeInsets.all(8.0),
                    //     child: TextFormField(
                    //       controller: searchBarController,
                    //       focusNode: searchBarFocusNode,
                    //       onTap: (){
                    //         CommonFunc.showToast("Chức năng đang trong quá trình xây dựng");
                    //       },
                    //       keyboardType: TextInputType.text,
                    //       style: const TextStyle(fontSize: 12),
                    //       decoration: InputDecoration(
                    //         isDense: true,
                    //         contentPadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    //         prefixIcon: const Icon(
                    //           Icons.search,
                    //           size: 20,
                    //         ),
                    //         hintText: "Bạn muốn tìm gì?",
                    //         fillColor: Colors.white,
                    //         focusedBorder: OutlineInputBorder(
                    //           borderSide: const BorderSide(
                    //               color: Colors.blueAccent, width: 1.0),
                    //           borderRadius: BorderRadius.circular(12.0),
                    //         ),
                    //         enabledBorder: OutlineInputBorder(
                    //           borderSide: const BorderSide(
                    //               color: Colors.grey, width: 1),
                    //           borderRadius: BorderRadius.circular(12),
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    const Spacer(),
                    IconButton(
                        onPressed: () {
                          CommonFunc.goToProfileScreen();
                        },
                        icon: const Icon(
                          Icons.account_circle_rounded,
                          color: Colors.blue,
                        ))
                  ],
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    color: Colors.white,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 4,
                    child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 2.2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Sữa mẹ bầu",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 205),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    fontStyle: FontStyle.italic),
                              ),
                              productViewModel.listTheThao.isNotEmpty
                                  ? listShoeByType(productViewModel.listTheThao)
                                  : Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Không có dữ liệu',style: TextStyle(fontSize: 12,color: Colors.grey),),
                              ),
                              const Text(
                                "Sữa người cao tuổi",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 205),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    fontStyle: FontStyle.italic),
                              ),
                              productViewModel.listDa.isNotEmpty
                                  ? listShoeByType(productViewModel.listDa)
                                  : Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Không có dữ liệu',style: TextStyle(fontSize: 12,color: Colors.grey),),
                              ),
                              const Text(
                                "Sữa cho bé",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 205),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    fontStyle: FontStyle.italic),
                              ),
                              productViewModel.listCaoGot.isNotEmpty
                                  ? listShoeByType(
                                      productViewModel.listCaoGot)
                                  : Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Không có dữ liệu',style: TextStyle(fontSize: 12,color: Colors.grey),),
                              ),
                              const Text(
                                "Sữa tươi tiệt trùng",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 205),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    fontStyle: FontStyle.italic),
                              ),
                              productViewModel.listBoot.isNotEmpty
                                  ? listShoeByType(productViewModel.listBoot)
                                  : Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Không có dữ liệu',style: TextStyle(fontSize: 12,color: Colors.grey),),
                              ),
                              const Text(
                                "Khác",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 205),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    fontStyle: FontStyle.italic),
                              ),
                              productViewModel.listGiayKhac.isNotEmpty
                                  ? listShoeByType(
                                      productViewModel.listGiayKhac)
                                  : Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('Không có dữ liệu',style: TextStyle(fontSize: 12,color: Colors.grey),),
                                  ),
                            ],
                          ),
                        )),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget listShoeByType(List<Product> sendas) {
    return SizedBox(
      height: 240,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: sendas.length,
        itemBuilder: (context, index) {
          return ProductItemCustomerView(product: sendas[index]);
        },
      ),
    );
  }
}
