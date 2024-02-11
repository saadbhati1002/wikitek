import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wikitek/api/repository/auth/auth.dart';
import 'package:wikitek/models/user_model.dart';
import 'package:wikitek/utility/colors.dart';
import 'package:wikitek/utility/constant.dart';
import 'package:wikitek/utility/images.dart';
import 'package:wikitek/widgets/common_button.dart';
import 'package:wikitek/widgets/common_text_fields.dart';
import 'package:wikitek/widgets/show_progress_bar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  bool isPasswordSeen = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 1,
            width: MediaQuery.of(context).size.width * 1,
            child: Image.asset(
              Images.slashBg,
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 1,
            width: MediaQuery.of(context).size.width * 1,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .28,
                    width: MediaQuery.of(context).size.width * 1,
                    child: Center(
                      child: Image.asset(
                        Images.logo,
                        width: MediaQuery.of(context).size.width * .4,
                      ),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * .72,
                    decoration: const BoxDecoration(
                      color: ColorConstant.whiteColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                alignment: Alignment.center,
                                child: const Text(
                                  'Sign in to your account to access thousands of products',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: ColorConstant.greyBlueColor,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.width * .07,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: CustomTextFormField(
                                  controller: emailController,
                                  context: context,
                                  hintText: 'Email address',
                                ),
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.width * .07,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: CustomTextFormField(
                                  controller: passwordController,
                                  isObscureText: isPasswordSeen,
                                  context: context,
                                  hintText: 'Email password',
                                  suffix: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isPasswordSeen = !isPasswordSeen;
                                      });
                                    },
                                    child: Icon(
                                      isPasswordSeen
                                          ? Icons.visibility_off
                                          : Icons.remove_red_eye,
                                      color: ColorConstant.greyBlueColor,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.width * .07,
                              ),
                              Container(
                                alignment: Alignment.topRight,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: const Text(
                                  "Forgot password?",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: ColorConstant.greyBlueColor,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.width * .07,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: CommonButton(
                                  onTap: () {
                                    loginCall();
                                  },
                                  title: 'Sign In',
                                  width: MediaQuery.of(context).size.width,
                                ),
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.width * .08,
                              ),
                              Container(
                                alignment: Alignment.center,
                                child: RichText(
                                  text: const TextSpan(
                                    text: "Don't have an account? ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        color: ColorConstant.greyBlueColor),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: 'Sign Up',
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: ColorConstant.mainColor,
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: const [
                              Text(
                                'Powered by',
                                style: TextStyle(
                                    fontSize: 12,
                                    color: ColorConstant.blackColor,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                'wikitek',
                                style: TextStyle(
                                    fontSize: 32,
                                    fontFamily: 'Magneto',
                                    color: ColorConstant.blackColor,
                                    fontWeight: FontWeight.w700),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          isLoading ? const ShowProgressBar() : const SizedBox(),
        ],
      ),
    );
  }

  loginCall() async {
    if (emailController.text.isEmpty) {
      toastShow(message: "Please enter your email");
      return;
    }
    if (!emailController.text.toString().contains("@")) {
      toastShow(message: "Please enter a valid email");
      return;
    }
    if (passwordController.text.isEmpty) {
      toastShow(message: "Please enter your password");
      return;
    }
    try {
      setState(() {
        isLoading = true;
      });
      UserRes response = await AuthRepository().loginUserApiCall(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
      if (response.success == true) {
        toastShow(message: response.message);
        await AppConstant.saveUserDetail(
          jsonEncode(response.userData),
        );
        AppConstant.userData = response.userData;
      } else {
        toastShow(message: response.message);
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}
