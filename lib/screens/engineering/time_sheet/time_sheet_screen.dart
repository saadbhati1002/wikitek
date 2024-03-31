import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:wikitek/api/repository/engineering/engineering.dart';
import 'package:wikitek/models/common_model.dart';
import 'package:wikitek/models/engineering/backlog/backlog_model.dart';
import 'package:wikitek/models/engineering/engineering_model.dart';
import 'package:wikitek/screens/dashboard/engineering/engineering_dashboard_screen.dart';
import 'package:wikitek/utility/colors.dart';
import 'package:wikitek/utility/constant.dart';
import 'package:wikitek/widgets/app_bar_add.dart';
import 'package:wikitek/widgets/common_button.dart';
import 'package:wikitek/widgets/common_text_fields.dart';
import 'package:wikitek/widgets/show_progress_bar.dart';

class TimeSheetScreen extends StatefulWidget {
  const TimeSheetScreen({super.key});

  @override
  State<TimeSheetScreen> createState() => _TimeSheetScreenState();
}

class _TimeSheetScreenState extends State<TimeSheetScreen> {
  TextEditingController mondayController = TextEditingController();
  TextEditingController tuesdayController = TextEditingController();
  TextEditingController wednesdayController = TextEditingController();
  TextEditingController thursdayController = TextEditingController();
  TextEditingController fridayController = TextEditingController();
  TextEditingController saturdayController = TextEditingController();
  TextEditingController sundayController = TextEditingController();
  List<EngineeringData> engineeringList = [];
  List<BacklogData> backlogList = [];

  String selectedEngineering = "Select Project";
  String selectedBackLog = "Select Backlog";
  String? selectedProjectID;
  String? selectedBacklogID;
  bool isAddTimeSheet = false;
  bool isLoading = false;

  @override
  void initState() {
    _getData();
    super.initState();
  }

  _getData() async {
    await _getEngineeringData();
  }

  _getEngineeringData() async {
    try {
      setState(() {
        isLoading = true;
      });
      engineeringList = [];
      EngineeringRes response =
          await EngineeringRepository().getEngineeringListApiCall();
      if (response.results!.isNotEmpty) {
        engineeringList = response.results!;

        await _getBackLock();
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future _getBackLock({String? projectID}) async {
    backlogList = [];

    try {
      setState(() {
        isLoading = true;
      });
      BacklogRes response = await EngineeringRepository()
          .getEngineeringBacklogApiCall(engineeringBacklog: projectID);
      if (response.results != null) {
        for (int backlogCount = 0;
            backlogCount < response.results!.length;
            backlogCount++) {
          if (response.results![backlogCount].backlogId != null &&
              response.results![backlogCount].backlogId != '' &&
              response.results![backlogCount].backlogId != "null") {
            backlogList.add(response.results![backlogCount]);
          }
        }
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
          setState(() {
            isAddTimeSheet = true;
          });
        },
        title: 'Engineering',
        subHeading: "TimeSheet",
      ),
      body: Stack(children: [
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      width: MediaQuery.of(context).size.width * .29,
                      child: const Text(
                        "Backlog:",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: ColorConstant.blackColor),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .6,
                      child: Text(
                        selectedBackLog == "Select Backlog"
                            ? ""
                            : selectedBackLog,
                        style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: ColorConstant.blackColor),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                textFieldWidget(title: "Mon", textController: mondayController),
                const SizedBox(
                  height: 10,
                ),
                textFieldWidget(
                    title: "Tue", textController: tuesdayController),
                const SizedBox(
                  height: 10,
                ),
                textFieldWidget(
                    title: "wed", textController: wednesdayController),
                const SizedBox(
                  height: 10,
                ),
                textFieldWidget(
                    title: "Thu", textController: thursdayController),
                const SizedBox(
                  height: 10,
                ),
                textFieldWidget(title: "Fri", textController: fridayController),
                const SizedBox(
                  height: 10,
                ),
                textFieldWidget(
                    title: "Sat", textController: saturdayController),
                const SizedBox(
                  height: 10,
                ),
                textFieldWidget(title: "Sun", textController: sundayController),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        mondayController.clear();
                        tuesdayController.clear();
                        wednesdayController.clear();
                        thursdayController.clear();
                        fridayController.clear();
                        saturdayController.clear();
                        sundayController.clear();
                        setState(() {});
                      },
                      child: Container(
                        height: 45,
                        width: MediaQuery.of(context).size.width * .35,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: ColorConstant.redColor),
                        alignment: Alignment.center,
                        child: const Text(
                          "Remove",
                          style: TextStyle(
                              fontSize: 16,
                              color: ColorConstant.whiteColor,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    CommonButton(
                      onTap: () {
                        isAddTimeSheet = false;
                        setState(() {
                          _submitTimeSheet();
                        });
                      },
                      title: 'Add',
                      width: MediaQuery.of(context).size.width * .35,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
        isAddTimeSheet == true ? addTimeSheet() : const SizedBox(),
        isLoading ? const ShowProgressBar() : const SizedBox(),
      ]),
    );
  }

  Widget textFieldWidget(
      {String? title, TextEditingController? textController}) {
    return Row(
      children: [
        Container(
          height: 45,
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width * .3,
          decoration: BoxDecoration(
              color: ColorConstant.mainColor,
              borderRadius: BorderRadius.circular(10)),
          child: Text(
            title!,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: ColorConstant.whiteColor),
          ),
        ),
        const SizedBox(
          width: 15,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * .58,
          child: selectedBacklogID != null
              ? CustomTextFormField(
                  keyboardType: TextInputType.number,
                  controller: textController,
                  context: context,
                  hintText: 'Hours',
                )
              : Container(
                  height: 45,
                  width: MediaQuery.of(context).size.width * .58,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: ColorConstant.greyBlueColor,
                      width: 1.5,
                    ),
                  ),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "Hours",
                    style: TextStyle(
                      color: ColorConstant.greyDarkColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
        )
      ],
    );
  }

  Widget addTimeSheet() {
    return Container(
      color: ColorConstant.blackColor.withOpacity(0.6),
      height: MediaQuery.of(context).size.height * .9,
      width: MediaQuery.of(context).size.width * 1,
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            color: ColorConstant.whiteColor,
            borderRadius: BorderRadius.circular(15),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 15),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * .34,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: MediaQuery.of(context).size.height * .019,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "",
                      maxLines: 1,
                      style: TextStyle(
                          fontSize: 18,
                          fontFamily: "roboto",
                          color: ColorConstant.bottomSheetColor,
                          fontWeight: FontWeight.w700),
                    ),
                    GestureDetector(
                      onTap: () {
                        isAddTimeSheet = false;
                        selectedEngineering = "Select Project";
                        selectedBackLog = "Select Project";
                        selectedProjectID = null;
                        selectedBacklogID = null;
                        setState(() {});
                      },
                      child: const FaIcon(
                        FontAwesomeIcons.xmark,
                        color: ColorConstant.redColor,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: ColorConstant.greyBlueColor,
                    ),
                    color: ColorConstant.whiteColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  height: 45,
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<EngineeringData>(
                        dropdownColor: ColorConstant.whiteColor,
                        icon: const Icon(
                          Icons.keyboard_arrow_down_sharp,
                          color: ColorConstant.greyDarkColor,
                        ),
                        isExpanded: true,
                        items: engineeringList.map((EngineeringData value) {
                          return DropdownMenuItem<EngineeringData>(
                            value: value,
                            child: Text(
                              value.projectId ?? '',
                            ),
                          );
                        }).toList(),
                        style: const TextStyle(
                          color: ColorConstant.greyBlueColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        hint: Text(
                          selectedEngineering,
                          maxLines: 1,
                          style: TextStyle(
                            color: selectedEngineering == "Select Project"
                                ? ColorConstant.greyDarkColor
                                : ColorConstant.bottomSheetColor,
                            fontSize: 16,
                            fontWeight: selectedEngineering == "Select Project"
                                ? FontWeight.w400
                                : FontWeight.w500,
                          ),
                        ),
                        onChanged: (value) {
                          selectedEngineering = value!.projectId!;
                          selectedProjectID = value.id;
                          selectedBacklogID = null;
                          selectedBackLog = "Select Backlog";
                          _getBackLock(projectID: value.id);
                          setState(() {});
                        },
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .03,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: ColorConstant.greyBlueColor,
                    ),
                    color: ColorConstant.whiteColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  height: 45,
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<BacklogData>(
                        dropdownColor: ColorConstant.whiteColor,
                        icon: const Icon(
                          Icons.keyboard_arrow_down_sharp,
                          color: ColorConstant.greyDarkColor,
                        ),
                        isExpanded: true,
                        items: backlogList.map((BacklogData value) {
                          return DropdownMenuItem<BacklogData>(
                            value: value,
                            child: Text(
                              value.backlogId ?? '',
                            ),
                          );
                        }).toList(),
                        style: const TextStyle(
                          color: ColorConstant.greyBlueColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        hint: Text(
                          selectedBackLog,
                          maxLines: 1,
                          style: TextStyle(
                            color: selectedBackLog == "Select Backlog"
                                ? ColorConstant.greyDarkColor
                                : ColorConstant.bottomSheetColor,
                            fontSize: 16,
                            fontWeight: selectedBackLog == "Select Backlog"
                                ? FontWeight.w400
                                : FontWeight.w500,
                          ),
                        ),
                        onChanged: (value) {
                          selectedBackLog = value!.backlogId!;
                          selectedBacklogID = value.backlogId;
                          setState(() {});
                        },
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .03,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: CommonButton(
                  onTap: () {
                    isAddTimeSheet = false;
                    setState(() {});
                  },
                  title: 'Save',
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .03,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future _submitTimeSheet() async {
    if (mondayController.text.isEmpty) {
      toastShow(message: "Please enter monday hours");
      return;
    }
    if (tuesdayController.text.isEmpty) {
      toastShow(message: "Please enter tuesday hours");
      return;
    }
    if (wednesdayController.text.isEmpty) {
      toastShow(message: "Please enter wednesday hours");
      return;
    }
    if (thursdayController.text.isEmpty) {
      toastShow(message: "Please enter thursday hours");
      return;
    }
    if (thursdayController.text.isEmpty) {
      toastShow(message: "Please enter thursday hours");
      return;
    }
    if (fridayController.text.isEmpty) {
      toastShow(message: "Please enter friday hours");
      return;
    }
    if (saturdayController.text.isEmpty) {
      toastShow(message: "Please enter saturday hours");
      return;
    }
    if (sundayController.text.isEmpty) {
      toastShow(message: "Please enter sunday hours");
      return;
    }

    String date = DateTime.now().toString();
    String firstDay = date.substring(0, 8) + '01' + date.substring(10);

    int weekDay = DateTime.parse(firstDay).weekday;
    DateTime testDate = DateTime.now();
    int weekOfMonth;
    weekDay--;
    weekOfMonth = ((testDate.day + weekDay) / 7).ceil();

    weekDay++;
    if (weekDay == 7) {
      weekDay = 0;
    }
    weekOfMonth = ((testDate.day + weekDay) / 7).ceil();
    try {
      setState(() {
        isLoading = true;
      });
      CommonRes response = await EngineeringRepository().createTimeSheetApiCall(
          backlogID: selectedBacklogID,
          friday: fridayController.text.trim(),
          monday: mondayController.text.trim(),
          projectID: selectedProjectID,
          saturday: saturdayController.text.trim(),
          sunday: sundayController.text.trim(),
          thursday: thursdayController.text.trim(),
          tuesday: tuesdayController.text.trim(),
          wednesday: wednesdayController.text.trim(),
          week: weekOfMonth.toString());
      if (response.success == true) {
        toastShow(message: "TimeSheet created successfully");
        selectedEngineering = "Select Project";
        selectedBackLog = "Select Backlog";
        mondayController.clear();
        tuesdayController.clear();
        wednesdayController.clear();
        thursdayController.clear();
        fridayController.clear();
        saturdayController.clear();
        sundayController.clear();
        setState(() {});
      } else {
        toastShow(message: "Please try again later");
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
