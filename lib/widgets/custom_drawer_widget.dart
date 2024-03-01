import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wikitek/screens/attendance/apply/apply_leave_screen.dart';
import 'package:wikitek/screens/dashboard/dashboard_screen.dart';
import 'package:wikitek/utility/colors.dart';

import 'package:wikitek/utility/images.dart';

class CustomDrawerWidget extends StatefulWidget {
  final VoidCallback? onTap;
  const CustomDrawerWidget({super.key, this.onTap});

  @override
  State<CustomDrawerWidget> createState() => _CustomDrawerWidgetState();
}

class _CustomDrawerWidgetState extends State<CustomDrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: ColorConstant.whiteColor,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * .4,
        height: MediaQuery.of(context).size.height * 1,
        child: Column(
          children: [
            Container(
              color: ColorConstant.mainColor,
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * .14,
              child: Center(
                child: Image.asset(
                  Images.logo,
                  width: MediaQuery.of(context).size.width * .2,
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              color: ColorConstant.mainColor.withOpacity(0.8),
              height: MediaQuery.of(context).size.height * .82,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .03,
                    ),
                    commonBox(
                      title: "Sales",
                      image: Images.sales,
                      onTap: () {
                        Get.to(
                          () => const DashBoardScreen(
                            index: 0,
                          ),
                        );
                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .03,
                    ),
                    commonBox(
                      title: "HR",
                      image: Images.hr,
                      onTap: () {
                        Get.to(
                          () => const ApplyLeaveScreen(),
                        );
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .03,
                    ),
                    commonBox(
                      title: "Warehouse",
                      image: Images.warehouse,
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .03,
                    ),
                    commonBox(
                      title: "Purchase",
                      image: Images.purchase,
                      onTap: () {
                        Navigator.pop(context);
                        Get.to(
                          () => const DashBoardScreen(
                            index: 3,
                          ),
                        );
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .03,
                    ),
                    commonBox(
                        title: "Logout",
                        image: Images.logout,
                        onTap: widget.onTap!),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .07,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget commonBox({String? title, String? image, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * .4,
        height: MediaQuery.of(context).size.height * .17,
        decoration: BoxDecoration(
          color: ColorConstant.whiteColor,
          borderRadius: BorderRadius.circular(7),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * .07,
              width: MediaQuery.of(context).size.height * .17,
              child: Image.asset(image!),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              title!,
              style: const TextStyle(
                  fontSize: 16,
                  color: ColorConstant.blackColor,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
