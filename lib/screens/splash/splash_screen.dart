import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wikitek/screens/auth/login/login_screen.dart';
import 'package:wikitek/utility/colors.dart';
import 'package:wikitek/utility/images.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2)).then((value) {
      mainNavigation();
    });
    super.initState();
  }

  mainNavigation() async {
    Get.to(
      () => const LoginScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height * 1,
        child: Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 1,
              width: MediaQuery.of(context).size.width * 1,
              child: Image.asset(
                Images.slashBg,
                fit: BoxFit.fill,
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Image.asset(Images.logo),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 1,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    Text(
                      'Powered by',
                      style: TextStyle(
                          fontSize: 12,
                          color: ColorConstant.whiteColor,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      'wikitek',
                      style: TextStyle(
                          fontSize: 32,
                          fontFamily: 'Magneto',
                          color: ColorConstant.whiteColor,
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
