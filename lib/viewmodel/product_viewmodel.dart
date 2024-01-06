import 'dart:async';
import 'dart:io';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:AppBanSuaOnline_Flutter/model/shoe_type.dart';
import 'package:rxdart/rxdart.dart';

import '../base/baseviewmodel/base_viewmodel.dart';
import '../data/repositories/product_repo/product_repo.dart';
import '../data/repositories/product_repo/product_repo_impl.dart';
import '../model/product.dart';
import '../model/roles_type.dart';
import '../model/status.dart';
import '../utils/common_func.dart';
import 'notification_viewmodel.dart';

class ProductViewModel extends BaseViewModel {
  static final ProductViewModel _instance = ProductViewModel._internal();

  factory ProductViewModel() {
    return _instance;
  }

  ProductViewModel._internal();

  ProductRepo productRepo = ProductRepoImpl();

  RolesType rolesType = RolesType.none;

  List<Product> products = [];
  List<Product> listTheThao = [];
  List<Product> listDa = [];
  List<Product> listCaoGot = [];
  List<Product> listBoot = [];
  List<Product> listGiayKhac = [];

  final StreamController<Status> getProductController =
      BehaviorSubject<Status>();

  Stream<Status> get getProductStream => getProductController.stream;

  @override
  FutureOr<void> init() {}

  onRolesChanged(RolesType rolesType) {
    this.rolesType = rolesType;
    notifyListeners();
  }

  Future<void> getAllProduct() async {
    products.clear();
    getProductController.sink.add(Status.loading);
    EasyLoading.show();
    productRepo.getAllProduct().then((value) {
      if (value.isNotEmpty) {
        products = value;
        //filter product by type
        filterProductByType();
        notifyListeners();
        getProductController.sink.add(Status.completed);
      }
      EasyLoading.dismiss();
    }).onError((error, stackTrace) {
      print("get senda error:${error.toString()}");
      getProductController.sink.add(Status.error);
      EasyLoading.dismiss();
    });
  }

  Future<void> addProduct(
      {required Product product, required File? imageFile}) async {
    await productRepo
        .addProduct(product: product, imageFile: imageFile)
        .then((value) async {
      if (value == true) {
        CommonFunc.showToast("Thêm thành công.");
        await getAllProduct();
        NotificationViewModel().newProductNotification();
      }
    }).onError((error, stackTrace) {
      print("add fail");
    });
  }

  Future<void> updateProduct(
      {required Product product, required File? imageFile}) async {
    await productRepo
        .updateProduct(product: product, imageFile: imageFile)
        .then((value) async {
      if (value == true) {
        CommonFunc.showToast("Cập nhật thành công.");
        await getAllProduct();
      }
    }).onError((error, stackTrace) {
      print("update fail");
    });
  }

  void deleteProduct({required String productId}) {
    productRepo.deleteProduct(productId: productId).then((value) {
      if (value == true) {
        CommonFunc.showToast("Xóa thành công.");
        //reload product
        getAllProduct();
      }
    }).onError((error, stackTrace) {
      print("add fail");
    });
  }

  void clearAllList() {
    listTheThao.clear();
    listDa.clear();
    listCaoGot.clear();
    listBoot.clear();
    listGiayKhac.clear();
  }

  void filterProductByType() {
    //clear all list
    clearAllList();

    //filter
    for (var element in products) {
      if (element.type == ShoeType.the_thao.toShortString()) {
        listTheThao.add(element);
      } else if (element.type == ShoeType.da.toShortString()) {
        listDa.add(element);
      } else if (element.type == ShoeType.cao_got.toShortString()) {
        listCaoGot.add(element);
      } else if (element.type == ShoeType.boot.toShortString()) {
        listBoot.add(element);
      } else {
        listGiayKhac.add(element);
      }
    }
  }
}
