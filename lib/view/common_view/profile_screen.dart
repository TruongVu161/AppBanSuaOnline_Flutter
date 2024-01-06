import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../model/roles_type.dart';
import '../../utils/common_func.dart';
import '../../utils/image_path.dart';
import '../../viewmodel/auth_viewmodel.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ProfileScreen();
}

class _ProfileScreen extends State<ProfileScreen> {
  AuthViewModel authViewModel = AuthViewModel();
  User? user;

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: const Text(
            "Hồ sơ của tôi",
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
          padding: EdgeInsets.only(
              left: 16,
              top: MediaQuery.of(context).padding.top + 8,
              right: 16,
              bottom: MediaQuery.of(context).padding.bottom + 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    backgroundImage: AssetImage(ImagePath.imgLogo),
                    radius: 28,
                  ),
                ),
              ),
              Center(
                child: Text(
                  CommonFunc.getUsernameByEmail(user?.email),
                  style: const TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
              Center(child: Text(authViewModel.rolesType == RolesType.admin ? "(Admin)" : "(Khách hàng)")),
              const Divider(
                thickness: 0.5,
                color: Colors.grey,
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    const Icon(
                      Icons.email,
                      size: 18,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(user?.email ?? "Unknown email"),
                    ),
                  ],
                ),
              ),
              // Text("khach1@gmail.com"),
              // Divider(thickness: 0.5,color: Colors.grey,height: 8,),
              Center(
                child: SizedBox(
                  width: 100,
                  child: TextButton(
                      onPressed: () async {
                        await authViewModel.logout();
                      },
                      child: const Text("Đăng xuất")),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
