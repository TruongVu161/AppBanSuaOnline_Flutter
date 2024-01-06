import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../model/roles_type.dart';
import '../../viewmodel/auth_viewmodel.dart';
import '../../viewmodel/notification_viewmodel.dart';
import '../../viewmodel/product_viewmodel.dart';
import 'custom_button.dart';
import 'login_screen.dart';

class SelectRole extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SelectRole();
}

class _SelectRole extends State<SelectRole> {
  AuthViewModel authViewModel = AuthViewModel();
  ProductViewModel productViewModel = ProductViewModel();
  int selectedRole = 1;

  @override
  void initState() {
    super.initState();
    NotificationViewModel().getAllFCMTokens();
  }

  void moveToLoginScreen(RolesType rolesType) {
    authViewModel.onRolesChanged(rolesType);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ListTile(
              title: const Text('Khách hàng'),
              leading: Radio<int>(
                value: 1,
                groupValue: selectedRole,
                onChanged: (int? value) {
                  setState(() {
                    selectedRole = value!;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('Admin'),
              leading: Radio<int>(
                value: 2,
                groupValue: selectedRole,
                onChanged: (int? value) {
                  setState(() {
                    selectedRole = value!;
                  });
                },
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: CustomButton(
                  onPressed: () {
                    RolesType rolesType = RolesType.none;
                    //Check selected roles
                    if (selectedRole == 1) {
                      rolesType = RolesType.customer;
                    } else if (selectedRole == 2) {
                      rolesType = RolesType.admin;
                    } else {
                      rolesType = RolesType.none;
                    }

                    if (rolesType == RolesType.customer ||
                        rolesType == RolesType.admin) {
                      //set roles type and move to login screen
                      moveToLoginScreen(rolesType);
                    } else {
                      Fluttertoast.showToast(
                          msg: "Vui lòng chọn vai trò của bạn.",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.black45,
                          textColor: Colors.white,
                          fontSize: 12.0
                      );
                    }
                  },
                  text: "Xác nhận",
                  textColor: Colors.white,
                  bgColor: Colors.blue),
            )
          ],
        ),
      ),
    );
  }
}
