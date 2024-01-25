// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:MysqlApp/Utils/AppColors/colors.dart';
import 'package:MysqlApp/Utils/NavBar/BottomNavBar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Auth/Functions.dart';

void main() async {
  Get.put(UserController());
  WidgetsFlutterBinding.ensureInitialized();
  await initSharedPreferences();
  UserController userController = UserController();
  userController.onInit(); // Explicitly call onInit
  runApp(const MyApp());
}

Future<void> initSharedPreferences() async {
  await SharedPreferences.getInstance();
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  static final navigatorKey = GlobalKey<NavigatorState>();

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late double screenHeight;
  late double screenWidth;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: MyApp.navigatorKey,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context)
              .copyWith(textScaler: const TextScaler.linear(1.0)),
          child: child!,
        );
      },
      theme: ThemeData(
        splashColor: Colur.transparent,
        highlightColor: Colur.transparent,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSwatch()
            .copyWith(secondary: Colur.white, brightness: Brightness.dark),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colur.transparent,
        ),
      ),
      home: const AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: Colur.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
        child: NavBar(),
      ),
    );
  }
}
