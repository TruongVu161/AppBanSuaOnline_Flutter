import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepo {
  Future<bool> signUp({required String email,required String password});
  Future<bool> addUser(User user);
  Future<User?> login({required String email, required String password, required bool isCheckAdmin});
}