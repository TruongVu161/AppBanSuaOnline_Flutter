import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/roles_type.dart';
import '../../utils/image_path.dart';
import '../../utils/notification_controller.dart';
import '../../viewmodel/auth_viewmodel.dart';
import '../../viewmodel/notification_viewmodel.dart';
import '../../viewmodel/order_viewmodel.dart';
import '../../viewmodel/post_viewmodel.dart';
import '../../viewmodel/product_viewmodel.dart';
import '../admin/admin_root_screen.dart';
import '../common_view/select_role.dart';
import '../customer/customer_home/customer_root_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> {
  late AuthViewModel authViewModel;
  late ProductViewModel productViewModel;
  late PostViewModel postViewModel;
  late OrderViewModel orderViewModel;
  final notifController = NotificationController();

  @override
  void initState() {
    super.initState();

    notifController.checkPermission();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Future.delayed(const Duration(seconds: 2), () {
        if (FirebaseAuth.instance.currentUser == null) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SelectRole()),
          );
        } else {
          FirebaseFirestore.instance
              .collection('USERS')
              .doc(FirebaseAuth.instance.currentUser?.uid)
              .get()
              .then((value) {
            bool isAdmin = value['isAdmin'] as bool;
            if (isAdmin) {
              authViewModel.onRolesChanged(RolesType.admin);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AdminRootScreen()),
              );
            } else {
              authViewModel.onRolesChanged(RolesType.customer);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CustomerRootScreen()),
              );
            }
            NotificationViewModel().getAllFCMTokens();
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    authViewModel = Provider.of<AuthViewModel>(context, listen: true);
    productViewModel = Provider.of<ProductViewModel>(context, listen: true);
    postViewModel = Provider.of<PostViewModel>(context, listen: true);
    orderViewModel = Provider.of<OrderViewModel>(context, listen: true);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          ImagePath.imgLogo,
          width: 300,
          height: 300,
        ),
      ),
    );
  }
}
