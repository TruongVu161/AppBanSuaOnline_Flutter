import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:AppBanSuaOnline_Flutter/utils/Constants.dart';

import '../../../model/fcm.dart';
import '../../../utils/common_func.dart';
import 'notification_repo.dart';
import 'package:dio/dio.dart';

class NotificationRepoImpl with NotificationRepo {
  @override
  Future<bool> newProductNotification({required String token}) async {
    final dio = Dio();
    dio.options.headers['content-Type'] = 'application/json';
    dio.options.headers["authorization"] =
        "key=${Constants.fcmAccessToken}";

    try {
      final response = await dio.post('https://fcm.googleapis.com/fcm/send', data: {
        "registration_ids": [token],
        "notification": {"body": "Có sản phầm mới vừa được thêm.", "title": "Sản phẩm mới", "sound": true},
        "data": {"content_type": "notification", "value": 2},
        "content_available": true,
        "priority": "high"
      });
    } catch (e) {
      print("reponse code:${e.toString()}");
    }
    return Future(() => true);
  }

  @override
  Future<List<FCM>> getFCMTokens() async {
    List<FCM> fcms = [];

    try {
      await FirebaseFirestore.instance.collection("FCM").get().then((querySnapshot) {
        for (var result in querySnapshot.docs) {
          fcms.add(FCM.fromJson(result.data()));
        }
        print("product length:${fcms.length}");
      });
      return fcms;
    } catch (error) {
      print("error:${error.toString()}");
    }

    return [];
  }

  @override
  Future<bool> addFMC({required FCM fcm}) {
    try {
      Map<String, dynamic> fcmMap = {
        "id": fcm.id,
        "email": fcm.email,
        "is_admin": fcm.isAdmin,
        "fcm_token": fcm.fcmToken,
      };

      FirebaseFirestore.instance.collection('FCM').doc(fcm.id).set(fcmMap)
        ..then((value) {
          return Future.value(true);
        }).catchError((error) {
          return Future.value(false);
        });
    } on FirebaseException catch (e) {
      CommonFunc.showToast("Đã có lỗi xảy ra.");
    } catch (e) {
      CommonFunc.showToast("Đã có lỗi xảy ra.");
    }
    return Future(() => true);
  }

  @override
  Future<bool> newOrderNotification({required String token}) async {
    print("token:$token");
    final dio = Dio();
    dio.options.headers['content-Type'] = 'application/json';
    dio.options.headers["authorization"] =
        "key=${Constants.fcmAccessToken}";

    try {
      final response = await dio.post('https://fcm.googleapis.com/fcm/send', data: {
        "registration_ids": [token],
        "notification": {"body": "Khách hàng vừa lên đơn mới.", "title": "Đơn hàng mới", "sound": true},
        "data": {"content_type": "notification", "value": 2},
        "content_available": true,
        "priority": "high"
      });
    } catch (e) {
      print("reponse code:${e.toString()}");
    }
    return Future(() => true);
  }

  @override
  Future<bool> newPostNotification({required String token}) async {
    final dio = Dio();
    dio.options.headers['content-Type'] = 'application/json';
    dio.options.headers["authorization"] =
    "key=${Constants.fcmAccessToken}";

    try {
      final response = await dio.post('https://fcm.googleapis.com/fcm/send', data: {
        "registration_ids": [token],
        "notification": {"body": "Có bài viết mới vừa được thêm.", "title": "Bài viết mới", "sound": true},
        "data": {"content_type": "notification", "value": 2},
        "content_available": true,
        "priority": "high"
      });
    } catch (e) {
      print("reponse code:${e.toString()}");
    }
    return Future(() => true);
  }
}
