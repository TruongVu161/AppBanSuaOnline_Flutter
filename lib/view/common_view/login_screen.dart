import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../model/roles_type.dart';
import '../../utils/validator.dart';
import '../../viewmodel/auth_viewmodel.dart';
import '../customer/authentication/signup_screen.dart';
import 'custom_button.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  TextEditingController emailController =
      TextEditingController();
  TextEditingController passwordController =
      TextEditingController();
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  AuthViewModel authViewModel = AuthViewModel();

  void goToSignUpScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignUpScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Đăng nhập",
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.grey,
              size: 20,
            )),
        elevation: 0,
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                  'Xin chào ${authViewModel.rolesType == RolesType.admin ? "ADMIN" : "KHÁCH HÀNG"}!',
                  style: const TextStyle(color: Colors.black, fontSize: 12)),
              const Padding(padding: EdgeInsets.only(top: 32)),
              TextFormField(
                controller: emailController,
                focusNode: emailFocusNode,
                keyboardType: TextInputType.emailAddress,
                autovalidateMode: AutovalidateMode.always,
                validator: (input) {
                  if (input!.isEmpty || Validators.isValidEmail(input)) {
                    return null;
                  } else {
                    return "Email không hợp lệ!";
                  }
                },
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(8),
                  labelText: "Email",
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.blueAccent, width: 2.0),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.redAccent, width: 1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.redAccent, width: 1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 16)),
              TextFormField(
                controller: passwordController,
                focusNode: passwordFocusNode,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(8),
                  labelText: "Mật khẩu",
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.blueAccent, width: 2.0),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 32)),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: CustomButton(
                    onPressed: () {
                      if (emailController.text.toString().trim().isNotEmpty &&
                          passwordController.text
                              .toString()
                              .trim()
                              .isNotEmpty) {
                        String email = emailController.text.toString().trim();
                        String password =
                            passwordController.text.toString().trim();
                        if (!Validators.isValidEmail(email)) {
                          Fluttertoast.showToast(
                              msg: "Vui lòng nhập đúng định dạng email.",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.black45,
                              textColor: Colors.white,
                              fontSize: 12.0);
                        } else {
                          authViewModel.login(
                              email: email,
                              password: password,
                              isCheckAdmin:
                                  authViewModel.rolesType == RolesType.admin);
                        }
                      } else {
                        Fluttertoast.showToast(
                            msg: "Vui lòng nhập đủ thông tin.",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.black45,
                            textColor: Colors.white,
                            fontSize: 12.0);
                      }
                    },
                    text: "Đăng nhập",
                    textColor: Colors.white,
                    bgColor: Colors.blue),
              ),
              const Padding(padding: EdgeInsets.only(top: 8)),
              GestureDetector(
                onTap: () {
                  print('Dang nhập');
                  goToSignUpScreen();
                },
                child: authViewModel.rolesType != RolesType.admin
                    ? const Text(
                        'Chưa có tài khoản? Đăng ký',
                        style:
                            TextStyle(color: Colors.blueAccent, fontSize: 12),
                      )
                    : const SizedBox(),
              )
            ],
          )),
    );
  }
}
