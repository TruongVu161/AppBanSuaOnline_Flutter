import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:AppBanSuaOnline_Flutter/utils/common_func.dart';
import 'package:AppBanSuaOnline_Flutter/utils/notification_controller.dart';
import 'package:AppBanSuaOnline_Flutter/view/splash_screen/splash_screen.dart';
import 'package:AppBanSuaOnline_Flutter/viewmodel/auth_viewmodel.dart';
import 'package:AppBanSuaOnline_Flutter/viewmodel/order_viewmodel.dart';
import 'package:AppBanSuaOnline_Flutter/viewmodel/post_viewmodel.dart';
import 'package:AppBanSuaOnline_Flutter/viewmodel/product_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

GlobalKey<NavigatorState> navigationKey = GlobalKey();

final formatCurrency = NumberFormat.currency(locale: 'vi',decimalDigits: 0,symbol: 'đ');

Future<void> main() async {
  await WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await NotificationController.initializeLocalNotifications(debug: true);
  await NotificationController.initializeRemoteNotifications(debug: true);

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.white, // navigation bar color
    statusBarColor: Colors.white, // status bar color
  ));

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => AuthViewModel()),
      ChangeNotifierProvider(create: (_) => ProductViewModel()),
      ChangeNotifierProvider(create: (_) => PostViewModel()),
      ChangeNotifierProvider(create: (_) => OrderViewModel())
    ],
    child: Builder(
      builder: (context) {
        return const MyApp();
      },
    ),
  ));

  CommonFunc.configLoading();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigationKey,
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      builder: EasyLoading.init(),
    );
  }
}
