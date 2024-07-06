import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletons/skeletons.dart';
import 'package:wikitek/api/repository/engineering/engineering.dart';
import 'package:wikitek/models/time_sheet/time_sheet_model.dart';
import 'package:wikitek/screens/dashboard/engineering/engineering_dashboard_screen.dart';
import 'package:wikitek/screens/engineering/time_sheet/time_sheet_screen.dart';
import 'package:wikitek/screens/engineering/time_sheet/update_time_sheet_screen.dart';
import 'package:wikitek/utility/colors.dart';
import 'package:wikitek/utility/constant.dart';
import 'package:wikitek/widgets/app_bar_add.dart';

class UserTimeSheetScreen extends StatefulWidget {
  const UserTimeSheetScreen({super.key});

  @override
  State<UserTimeSheetScreen> createState() => _UserTimeSheetScreenState();
}

class _UserTimeSheetScreenState extends State<UserTimeSheetScreen> {
  bool isLoading = false;
  List<TimeSheetData> timeSheetData = [];
  @override
  void initState() {
    _getTimeSheetData();
    super.initState();
  }

  Future _getTimeSheetData() async {
    try {
      setState(() {
        isLoading = true;
      });
      TimeSheetRes response =
          await EngineeringRepository().getUserTimeSheetApiCall();
      if (response.results != null) {
        timeSheetData = response.results!;
      }
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
      appBar: titleAppBarAddTitle(
        context: context,
        onTap: () {
          Get.to(() => const EngineeringDashBoardScreen());
        },
        addFunction: () {
          Get.to(() => const TimeSheetScreen());
        },
        title: 'Engineering',
        subHeading: "TimeSheet",
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            isLoading
                ? ListView.builder(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    itemCount: 10,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return engineeringSkelton();
                    },
                  )
                : timeSheetData.isNotEmpty
                    ? ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: timeSheetData.length,
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        itemBuilder: (context, index) {
                          return timeSheetData[index].project != null
                              ? GestureDetector(
                                  onTap: () async {
                                    await Get.to(
                                      () => UpdateTimeSheetScreen(
                                        data: timeSheetData[index],
                                      ),
                                    );
                                    _getTimeSheetData();
                                  },
                                  child: projectDetails(
                                    data: timeSheetData[index],
                                  ),
                                )
                              : const SizedBox();
                        },
                      )
                    : SizedBox(
                        height: MediaQuery.of(context).size.height * .8,
                        child: const Center(
                          child: Text(
                            "No Time Sheet Found",
                            style: TextStyle(
                                fontSize: 16,
                                color: ColorConstant.blackColor,
                                fontFamily: "roboto",
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
          ],
        ),
      ),
    );
  }

  Widget projectDetails({TimeSheetData? data}) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Material(
        elevation: 1,
        borderRadius: BorderRadius.circular(5),
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          decoration: BoxDecoration(
            color: ColorConstant.whiteColor,
            borderRadius: BorderRadius.circular(5),
          ),
          alignment: Alignment.centerLeft,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data!.project!.projectName ?? AppConstant.appName,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                data.user!.lastName != null
                    ? "${data.user!.firstName!} ${data.user!.lastName!}"
                    : data.user!.firstName ?? "",
                textAlign: TextAlign.left,
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                data.week != null ? "Week ${data.week}" : "",
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                data.year != null ? "Year ${data.year}" : "",
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget engineeringSkelton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Material(
        elevation: 2,
        borderRadius: BorderRadius.circular(10),
        shadowColor: ColorConstant.mainColor,
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 0.9, color: ColorConstant.mainColor),
          ),
          child: SkeletonTheme(
            themeMode: ThemeMode.light,
            child: SkeletonAvatar(
              style: SkeletonAvatarStyle(
                  height: 100, width: MediaQuery.of(context).size.width),
            ),
          ),
        ),
      ),
    );
  }
}
