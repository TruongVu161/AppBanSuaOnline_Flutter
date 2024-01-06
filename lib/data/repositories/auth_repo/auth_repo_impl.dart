import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../utils/common_func.dart';
import 'auth_repo.dart';

class AuthRepoImpl with AuthRepo {
  @override
  Future<User?> login(
      {required String email,
      required String password,
      required bool isCheckAdmin}) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      if (isCheckAdmin) {
        bool isAdmin = false;
        await FirebaseFirestore.instance
            .collection('USERS')
            .doc(credential.user?.uid)
            .get()
            .then((value) {
          isAdmin = value['isAdmin'] as bool;
        });
        if (isAdmin) {
          return FirebaseAuth.instance.currentUser;
        } else {
          CommonFunc.showToast("Tài khoản của bạn không có quyền Admin.");
          return null;
        }
      } else {
        return FirebaseAuth.instance.currentUser;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        CommonFunc.showToast("Không tìm thấy người dùng.");
      } else if (e.code == 'wrong-password') {
        CommonFunc.showToast("Sai tài khoản/mật khẩu.");
      }
    }
    return null;
  }

  @override
  Future<bool> signUp({required String email, required String password}) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      //save to firestore database
      if (FirebaseAuth.instance.currentUser != null) {
        await addUser(FirebaseAuth.instance.currentUser!).then((value) {
          print("add user success");
          return Future.value(true);
        }).onError((error, stackTrace) {
          print("add user error:${error.toString()}");
          return Future.value(false);
        });
      }
      return Future.value(true);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        CommonFunc.showToast("Mật khẩu quá yếu.");
      } else if (e.code == 'email-already-in-use') {
        CommonFunc.showToast("Email đã tồn tại.");
      }
    } catch (e) {
      print("signup error:${e.toString()}");
    }
    return Future.value(false);
  }

  @override
  Future<bool> addUser(User user) {
    try {
      Map<String, dynamic> userMap = {
        'username': user.email?.split("@").first, // John Doe
        'email': user.email,
        'isAdmin': false
      };

      FirebaseFirestore.instance.collection('USERS').doc(user.uid).set(userMap)
        ..then((value) {
          return Future.value(true);
        }).catchError((error) {
          CommonFunc.showToast("Lỗi thêm người dùng.");
          return Future.value(false);
        });
    } on FirebaseAuthException catch (e) {
      CommonFunc.showToast("Đã có lỗi xảy ra.");
      print("add user eror:${e.toString()}");
    } catch (e) {
      CommonFunc.showToast("Đã có lỗi xảy ra.");
    }
    return Future.value(false);
  }
}
