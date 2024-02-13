import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wikitek/screens/auth/register/register_screen.dart';
import 'package:wikitek/screens/splash/splash_screen.dart';
import 'package:wikitek/utility/constant.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppConstant.appName,
      theme: ThemeData(
        fontFamily: "Satoshi",
        primarySwatch: Colors.blue,
      ),
      home: const RegisterScreen(),
    );
  }
}
