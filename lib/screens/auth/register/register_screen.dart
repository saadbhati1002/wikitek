import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wikitek/api/repository/auth/auth.dart';
import 'package:wikitek/api/repository/market_place/market_place.dart';
import 'package:wikitek/api/repository/organization/organization.dart';
import 'package:wikitek/models/common_model.dart';
import 'package:wikitek/models/market_place/market_place_model.dart';
import 'package:wikitek/models/organization/organization_model.dart';
import 'package:wikitek/screens/auth/login/login_screen.dart';
import 'package:wikitek/screens/auth/otp_verification/otp_verification_screen.dart';
import 'package:wikitek/utility/colors.dart';
import 'package:wikitek/utility/constant.dart';
import 'package:wikitek/utility/images.dart';
import 'package:wikitek/widgets/common_button.dart';
import 'package:wikitek/widgets/common_text_fields.dart';
import 'package:wikitek/widgets/show_progress_bar.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isLoading = false;
  TextEditingController mobileController = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  List<OrganizationData> organizationList = [];
  List<MarketPlaceData> marketPlaceList = [];
  String? organizationName = "Select Organization";
  String? selectedOrganization;
  String? marketPlaceName = "Select Marketplace";
  String? selectedMarketPlace;
  bool isPasswordSeen = true;
  bool isConfirmPasswordSeen = true;

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    setState(() {
      isLoading = true;
    });
    await getOrganization();
    await getMarketPlace();
  }

  Future getOrganization() async {
    try {
      setState(() {
        isLoading = true;
      });
      OrganizationRes response =
          await OrganizationRepository().organizationApiCall();
      if (response.results!.isNotEmpty) {
        organizationList = response.results!;
      }
      return organizationList;
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future getMarketPlace() async {
    try {
      setState(() {
        isLoading = true;
      });
      MarketPlaceRes response =
          await MarketPlaceRepository().marketPlaceApiCall();
      if (response.results!.isNotEmpty) {
        marketPlaceList = response.results!;
      }
      return marketPlaceList;
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
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
                    height: MediaQuery.of(context).size.height * .22,
                    width: MediaQuery.of(context).size.width * 1,
                    child: Center(
                      child: Image.asset(
                        Images.logo,
                        width: MediaQuery.of(context).size.width * .35,
                      ),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * .78,
                    decoration: const BoxDecoration(
                      color: ColorConstant.whiteColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            alignment: Alignment.center,
                            child: const Text(
                              'Register with us to access thousands of products',
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
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: CustomTextFormField(
                              controller: firstName,
                              context: context,
                              hintText: 'First Name',
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.width * .05,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: CustomTextFormField(
                              controller: lastName,
                              context: context,
                              hintText: 'Last Name',
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.width * .05,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: CustomTextFormField(
                              controller: mobileController,
                              context: context,
                              hintText: 'Mobile Number',
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.width * .05,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: CustomTextFormField(
                              controller: emailController,
                              context: context,
                              hintText: 'Email address',
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.width * .05,
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: ColorConstant.greyBlueColor,
                              ),
                              color: ColorConstant.whiteColor,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            height: 45,
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 3),
                              child: DropdownButtonHideUnderline(
                                  child: DropdownButton<OrganizationData>(
                                dropdownColor: ColorConstant.whiteColor,
                                icon: const Icon(
                                  Icons.keyboard_arrow_down_sharp,
                                  color: ColorConstant.greyDarkColor,
                                ),
                                isExpanded: true,
                                items: organizationList
                                    .map((OrganizationData value) {
                                  return DropdownMenuItem<OrganizationData>(
                                    value: value,
                                    child: Text(
                                      value.companyName!,
                                    ),
                                  );
                                }).toList(),
                                style: const TextStyle(
                                  color: ColorConstant.greyBlueColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                                hint: Text(
                                  organizationName!,
                                  maxLines: 1,
                                  style: TextStyle(
                                    color: organizationName ==
                                            "Select Organization"
                                        ? ColorConstant.greyBlueColor
                                        : ColorConstant.blackColor,
                                    fontSize: organizationName ==
                                            "Select Organization"
                                        ? 16
                                        : 18,
                                    fontWeight: organizationName ==
                                            "Select Organization"
                                        ? FontWeight.w400
                                        : FontWeight.w600,
                                  ),
                                ),
                                onChanged: (value) {
                                  selectedOrganization = value?.companyName;
                                  organizationName = value?.companyName;
                                  setState(() {});
                                },
                              )),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.width * .05,
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: ColorConstant.greyBlueColor,
                              ),
                              color: ColorConstant.whiteColor,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            height: 45,
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 3),
                              child: DropdownButtonHideUnderline(
                                  child: DropdownButton<MarketPlaceData>(
                                dropdownColor: ColorConstant.whiteColor,
                                icon: const Icon(
                                  Icons.keyboard_arrow_down_sharp,
                                  color: ColorConstant.greyDarkColor,
                                ),
                                isExpanded: true,
                                items: marketPlaceList
                                    .map((MarketPlaceData value) {
                                  return DropdownMenuItem<MarketPlaceData>(
                                    value: value,
                                    child: Text(
                                      value.marketplaceName!,
                                    ),
                                  );
                                }).toList(),
                                style: const TextStyle(
                                  color: ColorConstant.greyBlueColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                                hint: Text(
                                  marketPlaceName!,
                                  maxLines: 1,
                                  style: TextStyle(
                                    color:
                                        marketPlaceName == "Select Marketplace"
                                            ? ColorConstant.greyBlueColor
                                            : ColorConstant.blackColor,
                                    fontSize:
                                        marketPlaceName == "Select Marketplace"
                                            ? 16
                                            : 18,
                                    fontWeight:
                                        marketPlaceName == "Select Marketplace"
                                            ? FontWeight.w400
                                            : FontWeight.w600,
                                  ),
                                ),
                                onChanged: (value) {
                                  marketPlaceName = value?.marketplaceName;
                                  selectedMarketPlace = value?.marketplaceName;
                                  setState(() {});
                                },
                              )),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.width * .05,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: CustomTextFormField(
                              controller: passwordController,
                              isObscureText: isPasswordSeen,
                              context: context,
                              hintText: 'Enter password',
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
                            height: MediaQuery.of(context).size.width * .05,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: CustomTextFormField(
                              controller: confirmPasswordController,
                              isObscureText: isConfirmPasswordSeen,
                              context: context,
                              hintText: 'Confirm password',
                              suffix: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isConfirmPasswordSeen =
                                        !isConfirmPasswordSeen;
                                  });
                                },
                                child: Icon(
                                  isConfirmPasswordSeen
                                      ? Icons.visibility_off
                                      : Icons.remove_red_eye,
                                  color: ColorConstant.greyBlueColor,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.width * .08,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: CommonButton(
                              onTap: () {
                                _registerCall();

                                // loginCall();
                              },
                              title: 'Sign Up',
                              width: MediaQuery.of(context).size.width,
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.width * .08,
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.to(() => const LoginScreen());
                            },
                            child: Container(
                              alignment: Alignment.center,
                              child: RichText(
                                text: const TextSpan(
                                  text: "Are you already member? ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      color: ColorConstant.greyBlueColor),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: 'Sign In',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: ColorConstant.mainColor,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.width * .08,
                          ),
                        ],
                      ),
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

  _registerCall() async {
    if (firstName.text.isEmpty) {
      toastShow(message: "Please enter your first name");
      return;
    }
    if (lastName.text.isEmpty) {
      toastShow(message: "Please enter your last name");
      return;
    }
    if (mobileController.text.isEmpty) {
      toastShow(message: "Please enter your phone number");
      return;
    }
    if (mobileController.text.toString().length != 10) {
      toastShow(
          message: "Please enter correct phone number without country code");
      return;
    }
    if (emailController.text.isEmpty) {
      toastShow(message: "Please enter your email");
      return;
    }
    if (!emailController.text.toString().contains("@")) {
      toastShow(message: "Please enter a valid email");
      return;
    }
    if (selectedOrganization == null) {
      toastShow(message: "Please select your organization");
      return;
    }
    if (selectedMarketPlace == null) {
      toastShow(message: "Please select your marketplace");
      return;
    }
    if (passwordController.text.isEmpty) {
      toastShow(message: "Please enter your password");
      return;
    }
    if (confirmPasswordController.text.isEmpty) {
      toastShow(message: "Please enter your confirm password");
      return;
    }
    if (passwordController.text.toString().trim() !=
        confirmPasswordController.text.toString().trim()) {
      toastShow(message: "Password and confirm password does not match");
      return;
    }
    try {
      setState(() {
        isLoading = true;
      });
      CommonRes response = await AuthRepository().registerUserApiCall(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
          firstName: firstName.text.trim(),
          lastName: lastName.text.trim(),
          marketPlace: selectedMarketPlace,
          mobileNumber: mobileController.text.trim(),
          organization: selectedOrganization);

      if (response.success == true) {
        toastShow(
            message:
                "Thank you for registering. Please verify your email before continuing.");

        Get.to(
          () => OTPVerificationScreen(
            emailUser: emailController.text.trim(),
            otpVerifyType: "Register",
          ),
        );
      } else {
        toastShow(message: "User already exists with this data.");
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
