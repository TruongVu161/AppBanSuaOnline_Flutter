

import '../../../model/fcm.dart';

abstract class NotificationRepo {
  Future<List<FCM>> getFCMTokens();
  Future<bool> addFMC({required FCM fcm});
  Future<bool> newProductNotification({required String token});
  Future<bool> newPostNotification({required String token});
  Future<bool> newOrderNotification({required String token});
}