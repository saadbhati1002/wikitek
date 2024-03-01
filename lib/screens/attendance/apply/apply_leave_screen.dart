import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wikitek/api/repository/attendance/attendance.dart';
import 'package:wikitek/models/common_model.dart';
import 'package:wikitek/utility/colors.dart';
import 'package:wikitek/utility/constant.dart';
import 'package:wikitek/widgets/app_bar_detail.dart';
import 'package:wikitek/widgets/common_button.dart';
import 'package:wikitek/widgets/common_text_fields.dart';
import 'package:wikitek/widgets/show_progress_bar.dart';

class ApplyLeaveScreen extends StatefulWidget {
  const ApplyLeaveScreen({super.key});

  @override
  State<ApplyLeaveScreen> createState() => _ApplyLeaveScreenState();
}

class _ApplyLeaveScreenState extends State<ApplyLeaveScreen> {
  TextEditingController selectedData = TextEditingController();
  DateTime? selectedDataTime;
  String? leaveType;
  String? leaveDay;
  String? leaveDayKey;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: titleAppBarTitle(
        isAmount: false,
        title: 'Attendance',
        subHeading: "Apply Leave",
        context: context,
        onTap: () {
          Navigator.pop(context);
        },
      ),
      body: Stack(
        children: [
          Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 25),
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
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      dropdownColor: ColorConstant.whiteColor,
                      icon: const Icon(
                        Icons.keyboard_arrow_down_sharp,
                        color: ColorConstant.greyDarkColor,
                      ),
                      isExpanded: true,
                      items: <String>["First Half", "Second Half", "Full Day"]
                          .map((String value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text(
                            value,
                          ),
                        );
                      }).toList(),
                      style: const TextStyle(
                        color: ColorConstant.greyBlueColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      hint: Text(
                        leaveDay != null ? leaveDay! : "Select Day",
                        maxLines: 1,
                        style: TextStyle(
                          color: leaveDay != null
                              ? ColorConstant.greyDarkColor
                              : ColorConstant.bottomSheetColor,
                          fontSize: 16,
                          fontWeight: leaveDay != null
                              ? FontWeight.w400
                              : FontWeight.w500,
                        ),
                      ),
                      onChanged: (value) {
                        leaveDay = value!;
                        if (value == "Full Day") {
                          leaveDayKey = "Full";
                        } else if (value == "First Half") {
                          leaveDayKey = "FirstHalf";
                        } else if (value == "Second Half") {
                          leaveDayKey = "SecondHalf";
                        }
                        setState(() {});
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 25),
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
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      dropdownColor: ColorConstant.whiteColor,
                      icon: const Icon(
                        Icons.keyboard_arrow_down_sharp,
                        color: ColorConstant.greyDarkColor,
                      ),
                      isExpanded: true,
                      items: <String>["Casual", "Sick"].map((String value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text(
                            value,
                          ),
                        );
                      }).toList(),
                      style: const TextStyle(
                        color: ColorConstant.greyBlueColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      hint: Text(
                        leaveType != null ? leaveType! : "Leave Type",
                        maxLines: 1,
                        style: TextStyle(
                          color: leaveType != null
                              ? ColorConstant.greyDarkColor
                              : ColorConstant.bottomSheetColor,
                          fontSize: 16,
                          fontWeight: leaveType != null
                              ? FontWeight.w400
                              : FontWeight.w500,
                        ),
                      ),
                      onChanged: (value) {
                        leaveType = value!;
                        if (selectedData.text.isNotEmpty) {
                          if (value == "Casual") {
                            if (!selectedDataTime!.isAfter(
                                DateTime.now().add(const Duration(days: 5)))) {
                              toastShow(
                                  message: "Please select date after 5 days");
                              _selectDate(context);
                            }
                          }
                        }
                        setState(() {});
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: CustomTextFormField(
                  onTap: () {
                    _selectDate(context);
                  },
                  controller: selectedData,
                  context: context,
                  hintText: 'Exp PO Date',
                  suffix: const Icon(
                    Icons.calendar_month_rounded,
                    color: ColorConstant.greyBlueColor,
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: CommonButton(
                  onTap: () {
                    _applyForLeave();
                  },
                  title: 'Sign In',
                  width: MediaQuery.of(context).size.width,
                ),
              ),
            ],
          ),
          isLoading ? const ShowProgressBar() : const SizedBox(),
        ],
      ),
    );
  }

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      if (leaveType == "Casual") {
        if (picked.isAfter(DateTime.now().add(const Duration(days: 5)))) {
          selectedData.text = DateFormat('yyyy-MM-dd').format(picked);
          selectedDataTime = picked;
        } else {
          toastShow(message: "Please select date after 5 days");
          _selectDate(context);
        }
      } else {
        selectedData.text = DateFormat('yyyy-MM-dd').format(picked);
        selectedDataTime = picked;
      }
      setState(() {});
    }
    FocusManager.instance.primaryFocus?.unfocus();
  }

  _applyForLeave() async {
    if (leaveDay == null) {
      toastShow(message: "Please select leave day");
      return;
    }
    if (leaveType == null) {
      toastShow(message: "Please select leave type");
      return;
    }
    if (selectedData.text.isEmpty) {
      toastShow(message: "Please select leave day");
      return;
    }
    try {
      setState(() {
        isLoading = true;
      });
      CommonRes response = await AttendanceRepository().applyForLeaveApiCall(
        leaveDate: selectedData.text.toString(),
        leaveType: leaveType,
        type: leaveDayKey,
      );
      if (response.success == true) {
        toastShow(message: "Applied for successfully");
        leaveDay = null;
        leaveType = null;
        leaveDayKey = null;
        selectedData.clear();
        selectedDataTime = null;
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
