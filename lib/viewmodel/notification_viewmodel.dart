import 'dart:async';

import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../base/baseviewmodel/base_viewmodel.dart';
import '../data/repositories/notification_repo/notification_repo.dart';
import '../data/repositories/notification_repo/notification_repo_impl.dart';
import '../model/fcm.dart';
import '../utils/common_func.dart';

class NotificationViewModel extends BaseViewModel {
  static final NotificationViewModel _instance = NotificationViewModel._internal();

  factory NotificationViewModel() {
    return _instance;
  }

  NotificationViewModel._internal();

  NotificationRepo notificationRepo = NotificationRepoImpl();

  List<FCM> fcms = [];

  List<FCM> userFCMs = [];
  List<FCM> adminFCMs = [];

  @override
  FutureOr<void> init() {}

  Future<void> getAllFCMTokens() async {
    fcms.clear();
    EasyLoading.show();
    await notificationRepo.getFCMTokens().then((value) {
      if (value.isNotEmpty) {
        fcms = value;
        filterUser(fcms);
        notifyListeners();
      }
      EasyLoading.dismiss();
    }).onError((error, stackTrace) {
      EasyLoading.dismiss();
    });
  }

  void filterUser(List<FCM> fcms) {
    userFCMs.clear();
    adminFCMs.clear();
    for (int index = 0; index < fcms.length; index++) {
      if (fcms[index].isAdmin) {
          adminFCMs.add(fcms[index]);
      } else {
          userFCMs.add(fcms[index]);
      }
    }
  }

  // bool isExist(List<FCM> fcm, String id){
  //   for (var element in fcm) {
  //     if(element.id == id) return true;
  //   }
  //   return false;
  // }

  Future<void> addFCM({required FCM fcm}) async {
    await notificationRepo.addFMC(fcm: fcm).then((value) async {
      if (value == true) {
        await getAllFCMTokens();
      }
    }).onError((error, stackTrace) {
      print("add fail");
    });
  }

  Future<void> newProductNotification() async {
    for (var element in userFCMs) {
      await notificationRepo.newProductNotification(token: element.fcmToken).then((value) async {
        if (value == true) {
          //Gui thong bao thanh cong den nguoi dung
        }
      }).onError((error, stackTrace) {
      });
    }
  }

  Future<void> newPostNotification() async {
    for (var element in userFCMs) {
      await notificationRepo.newPostNotification(token: element.fcmToken).then((value) async {
        if (value == true) {
          //Gui thong bao thanh cong den nguoi dung
        }
      }).onError((error, stackTrace) {
      });
    }
  }

  Future<void> newOrderNotification() async {
    for (var element in adminFCMs) {
      await notificationRepo.newOrderNotification(token: element.fcmToken).then((value) async {
        if (value == true) {
          //Gui thong bao thanh cong den admin thanh cong
        }
      }).onError((error, stackTrace) {
      });
    }
  }
}
