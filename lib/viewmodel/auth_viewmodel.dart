import 'dart:async';

import 'package:awesome_notifications_fcm/awesome_notifications_fcm.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../base/baseviewmodel/base_viewmodel.dart';
import '../data/repositories/auth_repo/auth_repo.dart';
import '../data/repositories/auth_repo/auth_repo_impl.dart';
import '../main.dart';
import '../model/fcm.dart';
import '../model/roles_type.dart';
import '../utils/common_func.dart';
import '../view/common_view/select_role.dart';
import 'notification_viewmodel.dart';

class AuthViewModel extends BaseViewModel {
  static final AuthViewModel _instance = AuthViewModel._internal();

  factory AuthViewModel() {
    return _instance;
  }

  AuthViewModel._internal();

  AuthRepo authRepo = AuthRepoImpl();

  RolesType rolesType = RolesType.none;

  @override
  FutureOr<void> init() {}

  onRolesChanged(RolesType rolesType) {
    this.rolesType = rolesType;
    notifyListeners();
  }

  Future<void> login({required String email, required String password, required bool isCheckAdmin}) async {
    EasyLoading.show();
    await authRepo.login(email: email, password: password, isCheckAdmin: isCheckAdmin).then((value) async {
      if (value != null) {
        if (rolesType == RolesType.admin) {
          CommonFunc.goToAdminRootScreen();
        } else {
          CommonFunc.goToCustomerRootScreen();
        }
        FCM fcm = FCM(
            id: UniqueKey().toString(),
            email: email,
            isAdmin: rolesType == RolesType.admin,
            fcmToken: await AwesomeNotificationsFcm().requestFirebaseAppToken());
        //Add FCM to receive notification
        NotificationViewModel().addFCM(fcm: fcm);
      }
      EasyLoading.dismiss();
    }).onError((error, stackTrace) {
      EasyLoading.dismiss();
      CommonFunc.showToast("Lỗi đăng nhập!");
    });
  }

  Future<void> signUp(String email, String password) async {
    EasyLoading.show();
    await authRepo.signUp(email: email, password: password).then((value) {
      EasyLoading.dismiss();
      if (value) {
        CommonFunc.showToast("Đăng ký thành công.");
        //back to login screen
        Navigator.of(navigationKey.currentContext!).pop();
      } else {
        print("sign up error");
      }
    }).onError((error, stackTrace) {
      EasyLoading.dismiss();
      CommonFunc.showToast("Đăng ký thất bại!");
    });
  }

  Future<void> logout() async {
    EasyLoading.show();
    await FirebaseAuth.instance.signOut();
    notifyListeners();
    EasyLoading.dismiss();
    if (FirebaseAuth.instance.currentUser == null) {
      Navigator.pushReplacement(navigationKey.currentContext!, MaterialPageRoute(builder: (context) => SelectRole()));
    }
  }
}
