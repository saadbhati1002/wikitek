import 'package:flutter/material.dart';
import 'package:wikitek/api/repository/auth/auth.dart';
import 'package:wikitek/models/common_model.dart';
import 'package:wikitek/utility/colors.dart';
import 'package:wikitek/utility/constant.dart';
import 'package:wikitek/utility/images.dart';
import 'package:wikitek/widgets/common_button.dart';
import 'package:wikitek/widgets/common_text_fields.dart';
import 'package:wikitek/widgets/show_progress_bar.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController emailController = TextEditingController();
  bool isLoading = false;
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
                    height: MediaQuery.of(context).size.height * .3,
                    width: MediaQuery.of(context).size.width * 1,
                    child: Center(
                      child: Image.asset(
                        Images.logo,
                        width: MediaQuery.of(context).size.width * .4,
                      ),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * .7,
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
                                height: 40,
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                alignment: Alignment.center,
                                child: const Text(
                                  'Please enter your email which registered with us',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: ColorConstant.greyBlueColor,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.width * .12,
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
                                height: MediaQuery.of(context).size.width * .12,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: CommonButton(
                                  onTap: () {
                                    _forgotPasswordFunction();
                                  },
                                  title: 'Verify',
                                  width: MediaQuery.of(context).size.width,
                                ),
                              ),
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

  _forgotPasswordFunction() async {
    if (emailController.text.isEmpty) {
      toastShow(message: "Please enter your email");
      return;
    }
    if (!emailController.text.toString().contains("@")) {
      toastShow(message: "Please enter a valid email");
      return;
    }
    try {
      setState(() {
        isLoading = true;
      });
      CommonRes response = await AuthRepository().forgotPasswordApiCall(
        email: emailController.text.trim(),
      );
      if (response.success == true) {
        toastShow(message: response.message);
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
