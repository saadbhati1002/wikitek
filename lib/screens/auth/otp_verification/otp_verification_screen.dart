import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wikitek/api/repository/auth/auth.dart';
import 'package:wikitek/models/auth/verify_otp_model.dart';

import 'package:wikitek/screens/auth/login/login_screen.dart';

import 'package:wikitek/utility/colors.dart';
import 'package:wikitek/utility/constant.dart';
import 'package:wikitek/utility/images.dart';
import 'package:wikitek/widgets/common_button.dart';
import 'package:wikitek/widgets/show_progress_bar.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class OTPVerificationScreen extends StatefulWidget {
  final String? emailUser;
  final String? otpVerifyType;
  const OTPVerificationScreen({super.key, this.emailUser, this.otpVerifyType});

  @override
  State<OTPVerificationScreen> createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen>
    with TickerProviderStateMixin {
  bool isLoading = false;
  AnimationController? _controller;
  int levelClock = 120;
  String? otp;
  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  _startTimer() {
    _controller = AnimationController(
        vsync: this, duration: Duration(seconds: levelClock));

    _controller!.forward();
  }

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
                                  'Enter your verification code',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: ColorConstant.blackColor,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                alignment: Alignment.center,
                                child: const Text(
                                  'We will send you an One Time Pass code via this email address/mobile phone',
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
                              OtpTextField(
                                fieldWidth: 45,
                                numberOfFields: 4,
                                borderColor: ColorConstant.mainColor,

                                showFieldAsBox: true,

                                onCodeChanged: (String code) {},

                                onSubmit: (String verificationCode) {
                                  otp = verificationCode;
                                }, // end onSubmit
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.width * .07,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Didn't get it? ",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: ColorConstant.greyDarkColor,
                                      ),
                                    ),
                                    Countdown(
                                      animation: StepTween(
                                        begin:
                                            levelClock, // THIS IS A USER ENTERED NUMBER
                                        end: 0,
                                      ).animate(_controller!),
                                    ),
                                  ],
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
                                    if (widget.otpVerifyType == "Register") {
                                      verifyRegisterUser();
                                    }
                                  },
                                  title: 'Submit',
                                  width: MediaQuery.of(context).size.width,
                                ),
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.width * .07,
                              ),
                              Container(
                                alignment: Alignment.center,
                                child: InkWell(
                                  onTap: () {
                                    if (_controller!.value.toString() ==
                                        "1.0") {
                                      _startTimer();
                                      toastShow(
                                          message: "OTP resend successfully");
                                      setState(() {});
                                    } else {
                                      toastShow(
                                          message: "Please wait for timer");
                                    }
                                  },
                                  child: const Text('Resend',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: ColorConstant.mainColor,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.width * .07,
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 25),
                                alignment: Alignment.center,
                                child: RichText(
                                  textAlign: TextAlign.center,
                                  text: const TextSpan(
                                    text:
                                        "By Clicking the Submit button, you agree to our ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        color: ColorConstant.greyBlueColor),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text:
                                            'Privacy Policy | Terms & Conditions',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: ColorConstant.mainColor,
                                            fontWeight: FontWeight.bold),
                                      ),
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

  verifyRegisterUser() async {
    if (otp == null) {
      toastShow(message: "Please Enter OTP.");
      return;
    }
    if (otp!.length == 4) {
      try {
        OTPVerify response = await AuthRepository()
            .verifyRegisterEmailApiCall(email: widget.emailUser, otp: otp);
        if (response.success == true) {
          toastShow(message: "Your account is verified. Please login Now");
          Get.off(() => const LoginScreen());
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
}

class Countdown extends AnimatedWidget {
  Countdown({Key? key, this.animation})
      : super(key: key, listenable: animation!);
  final Animation<int>? animation;

  @override
  build(BuildContext context) {
    Duration clockTimer = Duration(seconds: animation!.value);

    String timerText =
        '${clockTimer.inMinutes.remainder(60).toString()}:${clockTimer.inSeconds.remainder(60).toString().padLeft(2, '0')}';

    return Text(
      timerText.toString(),
      style: const TextStyle(
        fontSize: 16,
        color: ColorConstant.greyDarkColor,
      ),
    );
  }
}
