import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../utils/validator.dart';
import '../../../viewmodel/auth_viewmodel.dart';
import '../../common_view/custom_button.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginScreen();
}

class _LoginScreen extends State<SignUpScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController reEnterPasswordController = TextEditingController();
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode reEnterPasswordFocusNode = FocusNode();
  AuthViewModel authViewModel = AuthViewModel();

  void backToLoginScreen() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Đăng ký",
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
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
                    borderSide: const BorderSide(color: Colors.blueAccent, width: 2.0),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.redAccent, width: 1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.redAccent, width: 1),
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
                    borderSide: const BorderSide(color: Colors.blueAccent, width: 2.0),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 16)),
              TextFormField(
                controller: reEnterPasswordController,
                focusNode: reEnterPasswordFocusNode,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(8),
                  labelText: "Nhập lại mật khẩu",
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.blueAccent, width: 2.0),
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
                          passwordController.text.toString().trim().isNotEmpty &&
                          reEnterPasswordController.text.toString().trim().isNotEmpty) {
                        String email = emailController.text.toString().trim();
                        String password = passwordController.text.toString().trim();
                        String reEnterPassword = reEnterPasswordController.text.toString().trim();
                        if (!Validators.isValidEmail(email)) {
                          Fluttertoast.showToast(
                              msg: "Vui lòng nhập đúng định dạng email.",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.black45,
                              textColor: Colors.white,
                              fontSize: 12.0);
                        } else if (password != reEnterPassword) {
                          Fluttertoast.showToast(
                              msg: "Nhập lại mật khẩu không khớp.",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.black45,
                              textColor: Colors.white,
                              fontSize: 12.0);
                        } else {
                          authViewModel.signUp(email, password);
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
                    text: "Đăng ký",
                    textColor: Colors.white,
                    bgColor: Colors.blue),
              ),
              const Padding(padding: EdgeInsets.only(top: 8)),
              GestureDetector(
                onTap: () {
                  backToLoginScreen();
                },
                child: const Text(
                  'Đã có tài khoản? Đăng nhập',
                  style: TextStyle(color: Colors.blueAccent, fontSize: 12),
                ),
              )
            ],
          )),
    );
  }
}
