class FCM {
  String id = "";
  String email = "";
  bool isAdmin = false;
  String fcmToken = "";

  FCM({required this.id, required this.email, required this.isAdmin, required this.fcmToken});

  FCM.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    isAdmin = json['is_admin'];
    fcmToken = json['fcm_token'];
  }
}
