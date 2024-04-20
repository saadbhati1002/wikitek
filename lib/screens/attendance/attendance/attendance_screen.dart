import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wikitek/api/repository/attendance/attendance.dart';
import 'package:wikitek/models/attendance/attendance_model.dart';
import 'package:wikitek/models/attendance/org_holiday/org_holiday_model.dart';
import 'package:wikitek/models/attendance/org_user_model/org_user_model.dart';
import 'package:wikitek/screens/attendance/apply/apply_leave_screen.dart';
import 'package:wikitek/utility/colors.dart';
import 'package:wikitek/utility/constant.dart';
import 'package:wikitek/widgets/app_bar_title.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:wikitek/widgets/show_progress_bar.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  bool isLoading = false;
  int appliedLeaves = 0;
  int approvedLeave = 0;
  int disapprovedLeave = 0;
  double totalLeaveTaken = 0.0;
  int totalLive = 0;
  int organizationHoliday = 0;
  // CalendarController _calendarController;

  List<AttendanceData> attendanceList = [];
  List<OrgUserData> orgUserList = [];
  List<OrgHolidayData> orgHolidayList = [];
  List<DateTime> everyMonthSaturday = [];

  @override
  void initState() {
    _getData();
    super.initState();
  }

  _getData() async {
    _getSaturday();
    await _getAttendance();
    await _getOrgUser();
    await _getOrgHoliday();
  }

  _getSaturday() {
    List<DateTime> saturdays = [];

    DateTime currentDate = DateTime.now();

    DateTime firstDayOfMonth = DateTime(currentDate.year, currentDate.month, 1);

    DateTime firstSaturday = firstDayOfMonth
        .add(Duration(days: DateTime.saturday - firstDayOfMonth.weekday));

    // Add the first Saturday to the list
    saturdays.add(firstSaturday);

    // Find subsequent Saturdays of the month
    while (firstSaturday.month == currentDate.month) {
      firstSaturday = firstSaturday.add(const Duration(days: 7));
      if (firstSaturday.month == currentDate.month) {
        saturdays.add(firstSaturday);
      }
    }

    for (DateTime saturday in saturdays) {}
    for (int i = 0; i < saturdays.length; i++) {
      if (i == 1 || i == 3) {
        everyMonthSaturday.add(saturdays[i]);
      }
    }
    setState(() {});
  }

  Future _getAttendance() async {
    try {
      setState(() {
        isLoading = true;
      });
      AttendanceRes response =
          await AttendanceRepository().getAttendanceApiCall();
      if (response.results.isNotEmpty) {
        attendanceList = response.results;
        // appliedLeaves = response.count!;
        _getApprovedLeaves();
        _getDisapprovedLeaves();
        _getDataSource();
      }
      return attendanceList;
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future _getOrgUser() async {
    try {
      setState(() {
        isLoading = true;
      });
      OrgUserRes response = await AttendanceRepository().getOrgUserApiCall();
      if (response.results!.isNotEmpty) {
        orgUserList = response.results!;
        _getTotalLeaves();
        _getDataSource();
      }
      return attendanceList;
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future _getOrgHoliday() async {
    try {
      setState(() {
        isLoading = true;
      });
      OrgHolidayRes response =
          await AttendanceRepository().getOrgHolidayApiCall();
      if (response.results!.isNotEmpty) {
        orgHolidayList = response.results!;
        organizationHoliday = orgHolidayList[0].holidayDate.length;
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  _getTotalLeaves() {
    for (int i = 0; i < orgUserList.length; i++) {
      if (orgUserList[i].email == AppConstant.userData?.email) {
        print(orgUserList[i].doj);
        print("saad bhati");
        print(orgUserList[i].doc);
        if (orgUserList[i].doc != null) {
          if (DateTime.parse(orgUserList[i].doc!)
              .isBefore(AppConstant.currentFinicalYearStart)) {
            totalLive = 12 * 2;
          }
        } else if (orgUserList[i].doc == null) {
          totalLive = 12;
        } else if (DateTime.parse(orgUserList[i].doc!)
            .isBefore(AppConstant.currentFinicalYearStart)) {
          int internshipsMonths;
          internshipsMonths = DateTime.parse(orgUserList[i].doc!).month - 3;
          int jobMonths = 12 - internshipsMonths;
          totalLive = internshipsMonths + jobMonths * 2;
        }
      }
      //   if (DateTime.now().month < 4) {
      //     if ((DateTime.parse(orgUserList[i].doj!)).year <
      //         DateTime.now().year - 1) {
      //       if ((DateTime.parse(orgUserList[i].doc!)).year ==
      //           DateTime.now().year - 1) {
      //         if ((DateTime.parse(orgUserList[i].doc!)).month > 3) {
      //           String fullTimePeriod = ((DateTime.now().year -
      //                           (DateTime.parse(orgUserList[i].doc!)).year) *
      //                       12 +
      //                   DateTime.now().month -
      //                   (DateTime.parse(orgUserList[i].doc!)).month)
      //               .toStringAsFixed(0);

      //           totalLive = totalLive + int.parse(fullTimePeriod) * 2;
      //         } else {
      //           String fullTimePeriod =
      //               (((DateTime.now().year) - (DateTime.now().year - 1)) *
      //                           12 +
      //                       DateTime.now().month -
      //                       3)
      //                   .toStringAsFixed(0);

      //           totalLive = totalLive + int.parse(fullTimePeriod) * 2;
      //         }
      //       } else {
      //         String fullTimePeriod =
      //             (((DateTime.now().year) - (DateTime.now().year - 1)) * 12 +
      //                     DateTime.now().month -
      //                     3)
      //                 .toStringAsFixed(0);

      //         totalLive = totalLive + int.parse(fullTimePeriod) * 2;
      //       }
      //     } else {
      //       if ((DateTime.parse(orgUserList[i].doj!)).month > 3) {
      //         int differenceInMonths =
      //             ((DateTime.parse(orgUserList[i].doc!)).year -
      //                         (DateTime.parse(orgUserList[i].doj!)).year) *
      //                     12 +
      //                 (DateTime.parse(orgUserList[i].doc!)).month -
      //                 (DateTime.parse(orgUserList[i].doj!)).month;

      //         totalLive = totalLive + differenceInMonths;
      //         if ((DateTime.parse(orgUserList[i].doc!)).year ==
      //             DateTime.now().year - 1) {
      //           if ((DateTime.parse(orgUserList[i].doc!)).month > 3) {
      //             String fullTimePeriod = ((DateTime.now().year -
      //                             (DateTime.parse(orgUserList[i].doc!))
      //                                 .year) *
      //                         12 +
      //                     DateTime.now().month -
      //                     (DateTime.parse(orgUserList[i].doc!)).month)
      //                 .toStringAsFixed(0);

      //             totalLive = totalLive + (int.parse(fullTimePeriod) + 1) * 2;
      //           } else {
      //             String fullTimePeriod =
      //                 (((DateTime.now().year) - (DateTime.now().year - 1)) *
      //                             12 +
      //                         DateTime.now().month -
      //                         3)
      //                     .toStringAsFixed(0);

      //             totalLive = totalLive + int.parse(fullTimePeriod) * 2;
      //           }
      //         } else {
      //           String fullTimePeriod = ((DateTime.now().year -
      //                           (DateTime.parse(orgUserList[i].doc!)).year) *
      //                       12 +
      //                   DateTime.now().month -
      //                   (DateTime.parse(orgUserList[i].doc!)).month)
      //               .toStringAsFixed(0);

      //           totalLive = totalLive + (int.parse(fullTimePeriod) + 1) * 2;
      //         }
      //       } else {
      //         int differenceInMonths =
      //             ((DateTime.parse(orgUserList[i].doc!)).year -
      //                         (DateTime.parse(orgUserList[i].doj!)).year) *
      //                     12 +
      //                 (DateTime.parse(orgUserList[i].doc!)).month -
      //                 4;

      //         totalLive = totalLive + differenceInMonths;
      //         if ((DateTime.parse(orgUserList[i].doc!)).year ==
      //             DateTime.now().year - 1) {
      //           if ((DateTime.parse(orgUserList[i].doc!)).month > 3) {
      //             String fullTimePeriod = ((DateTime.now().year -
      //                             (DateTime.parse(orgUserList[i].doc!))
      //                                 .year) *
      //                         12 +
      //                     DateTime.now().month -
      //                     (DateTime.parse(orgUserList[i].doc!)).month)
      //                 .toStringAsFixed(0);

      //             totalLive = totalLive + (int.parse(fullTimePeriod) + 1) * 2;
      //           } else {
      //             String fullTimePeriod =
      //                 (((DateTime.now().year) - (DateTime.now().year - 1)) *
      //                             12 +
      //                         DateTime.now().month -
      //                         3)
      //                     .toStringAsFixed(0);

      //             totalLive = totalLive + int.parse(fullTimePeriod) * 2;
      //           }
      //         }
      //       }
      //     }
      //   }
      // } else {
      //   if (orgUserList[i].doj != null) {
      //     int differenceInMonths = (DateTime.now().year -
      //                 (DateTime.parse(orgUserList[i].doj!)).year) *
      //             12 +
      //         DateTime.now().month -
      //         (DateTime.parse(orgUserList[i].doj!)).month;

      //     totalLive = totalLive + differenceInMonths + 1;
      //   }
      //   if (orgUserList[i].doc != null) {
      //     String fullTimePeriod = (DateTime.now()
      //                 .difference(DateTime.parse(orgUserList[i].doc!))
      //                 .inDays %
      //             365 /
      //             30)
      //         .toStringAsFixed(0);

      //     totalLive = totalLive + (int.parse(fullTimePeriod) + 1) * 2;
      //   }
      // }
      // }
    }
  }

  _getApprovedLeaves() {
    for (int i = 0; i < attendanceList.length; i++) {
      for (int j = 0; j < attendanceList[i].leaveDates.length; j++) {
        if (DateTime.parse(attendanceList[i].leaveDates[j].date!)
                .isAfter(AppConstant.currentFinicalYearStart) &&
            DateTime.parse(attendanceList[i].leaveDates[j].date!)
                .isBefore(AppConstant.currentFinicalYearEnd)) {
          appliedLeaves = appliedLeaves + 1;
          if (attendanceList[i].leaveDates[j].status == "Approved") {
            approvedLeave = approvedLeave + 1;

            if (attendanceList[i].leaveDates[j].type == "Firsthalf") {
              totalLeaveTaken = totalLeaveTaken + 0.5;
            } else if (attendanceList[i].leaveDates[j].type == "Secondhalf") {
              totalLeaveTaken = totalLeaveTaken + 0.5;
            } else if (attendanceList[i].leaveDates[j].type == "Full") {
              totalLeaveTaken = totalLeaveTaken + 1;
            }
          }
        }

        setState(() {});
      }
    }
  }

  _getDisapprovedLeaves() {
    for (int i = 0; i < attendanceList.length; i++) {
      for (int j = 0; j < attendanceList[i].leaveDates.length; j++) {
        if (DateTime.parse(attendanceList[i].leaveDates[j].date!)
                .isAfter(AppConstant.currentFinicalYearStart) &&
            DateTime.parse(attendanceList[i].leaveDates[j].date!)
                .isBefore(AppConstant.currentFinicalYearEnd)) {
          if (attendanceList[i].leaveDates[j].status == "Disapproved") {
            disapprovedLeave = disapprovedLeave + 1;
          }
        }
      }
      setState(() {});
    }
  }

  List<Meeting> _getDataSource() {
    final List<Meeting> meetings = <Meeting>[];
    if (attendanceList.isNotEmpty) {
      for (int i = 0; i < attendanceList.length; i++) {
        if (attendanceList[i].leaveDates.isNotEmpty) {
          if (attendanceList[i]
                  .leaveDates[attendanceList[i].leaveDates.length - 1]
                  .date !=
              null) {
            if (attendanceList[i]
                    .leaveDates[attendanceList[i].leaveDates.length - 1]
                    .status ==
                "Approved") {
              meetings.add(
                Meeting(
                    'Approved Leaves',
                    DateTime.parse(attendanceList[i]
                        .leaveDates[attendanceList[i].leaveDates.length - 1]
                        .date!),
                    DateTime.parse(attendanceList[i]
                        .leaveDates[attendanceList[i].leaveDates.length - 1]
                        .date!),
                    const Color(0xFF0F8644),
                    true),
              );
            } else if (attendanceList[i]
                    .leaveDates[attendanceList[i].leaveDates.length - 1]
                    .status ==
                "Disapproved") {
              meetings.add(
                Meeting(
                    'Disapproved Leaves',
                    DateTime.parse(attendanceList[i]
                        .leaveDates[attendanceList[i].leaveDates.length - 1]
                        .date!),
                    DateTime.parse(attendanceList[i]
                        .leaveDates[attendanceList[i].leaveDates.length - 1]
                        .date!),
                    Colors.redAccent,
                    true),
              );
            } else if (attendanceList[i]
                    .leaveDates[attendanceList[i].leaveDates.length - 1]
                    .status ==
                "Applied") {
              meetings.add(
                Meeting(
                    'Applied',
                    DateTime.parse(attendanceList[i]
                        .leaveDates[attendanceList[i].leaveDates.length - 1]
                        .date!),
                    DateTime.parse(attendanceList[i]
                        .leaveDates[attendanceList[i].leaveDates.length - 1]
                        .date!),
                    ColorConstant.greyBlueColor,
                    true),
              );
            }
          }
        }
      }
    }
    for (int i = 0; i < orgHolidayList.length; i++) {
      for (int j = 0; j < orgHolidayList[i].holidayDate.length; j++) {
        if (orgHolidayList[i].holidayDate[j].date != null) {
          meetings.add(
            Meeting(
                'Organization HOliday',
                DateTime.parse(orgHolidayList[i].holidayDate[j].date!),
                DateTime.parse(orgHolidayList[i].holidayDate[j].date!),
                Colors.yellow,
                true),
          );
        }
      }
    }
    if (everyMonthSaturday.isNotEmpty) {
      for (int i = 0; i < everyMonthSaturday.length; i++) {
        meetings.add(
          Meeting('Organization HOliday', everyMonthSaturday[i],
              everyMonthSaturday[i], Colors.blueGrey, true),
        );
      }
    }

    return meetings;
  }

  _getBalanceLeave() {
    var value = (totalLive - totalLeaveTaken).toString();
    return value.contains("-") ? "0" : value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.backgroundColor,
      appBar: titleAppBar(
        context: context,
        isAmount: false,
        isHome: false,
        title: "Attendance",
        onTap: () {
          Navigator.pop(context);
        },
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      commonBox(
                        color: ColorConstant.greyOffColor,
                        count: "02",
                        title: "Week Off",
                      ),
                      commonBox(
                        color: ColorConstant.yellowOffColor,
                        count: organizationHoliday.toString(),
                        title: "ORG Holiday",
                      ),
                      commonBox(
                        color: ColorConstant.greyBlueColor.withOpacity(0.4),
                        count: appliedLeaves.toString(),
                        title: "Applied Leaves",
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      commonBox(
                        color: ColorConstant.redOffColor,
                        count: disapprovedLeave.toString(),
                        title: "Disapproved Leave",
                      ),
                      commonBox(
                        color: ColorConstant.greenOffColor,
                        count: approvedLeave.toString(),
                        title: "Approved Leave",
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.to(() => const ApplyLeaveScreen());
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * .29,
                          height: MediaQuery.of(context).size.height * .11,
                          decoration: BoxDecoration(
                            color: ColorConstant.mainColor,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          alignment: Alignment.center,
                          child: const Text(
                            "Apply Leave",
                            style: TextStyle(
                              color: ColorConstant.whiteColor,
                              fontWeight: FontWeight.w500,
                              fontFamily: "roboto",
                              fontSize: 15,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: ColorConstant.whiteColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: SfCalendar(
                      dataSource: MeetingDataSource(_getDataSource()),
                      view: CalendarView.month,
                      allowAppointmentResize: true,
                      monthViewSettings: const MonthViewSettings(
                          monthCellStyle: MonthCellStyle(),
                          agendaStyle: AgendaStyle(
                            appointmentTextStyle: TextStyle(fontSize: 14),
                          ),
                          appointmentDisplayMode:
                              MonthAppointmentDisplayMode.indicator),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      commonBox(
                        color: ColorConstant.greyOffColor,
                        count: totalLive.toString(),
                        title: "Total Leaves",
                      ),
                      commonBox(
                        color: ColorConstant.yellowOffColor,
                        count: totalLeaveTaken.toString(),
                        title: "Taken Leaves",
                      ),
                      commonBox(
                        color: ColorConstant.greyBlueColor.withOpacity(0.4),
                        count: _getBalanceLeave(),
                        title: "Balance Leaves",
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  color: ColorConstant.mainColor,
                  height: 30,
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  child: rowContainer(),
                ),
                const SizedBox(
                  height: 5,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: attendanceList.length,
                  itemBuilder: (context, index) {
                    return appliedAttendanceWidgetList(
                      index,
                    );
                  },
                ),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
          isLoading ? const ShowProgressBar() : const SizedBox(),
        ],
      ),
    );
  }

  Widget commonBox({Color? color, String? count, String? title}) {
    return Container(
      width: MediaQuery.of(context).size.width * .29,
      height: MediaQuery.of(context).size.height * .11,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            count ?? '',
            style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontFamily: "roboto",
                fontSize: 20),
          ),
          const SizedBox(
            height: 3,
          ),
          Text(
            title ?? '',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontFamily: "roboto",
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget rowContainer() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width * .25,
            child: const Text(
              "Leave Date",
              style: TextStyle(
                  fontSize: 14,
                  color: ColorConstant.whiteColor,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width * .215,
            child: const Text(
              "Type",
              style: TextStyle(
                  fontSize: 14,
                  color: ColorConstant.whiteColor,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width * .25,
            child: const Text(
              "Day",
              style: TextStyle(
                  fontSize: 14,
                  color: ColorConstant.whiteColor,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width * .23,
            child: const Text(
              "Status",
              style: TextStyle(
                  fontSize: 14,
                  color: ColorConstant.whiteColor,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  Widget appliedAttendanceWidgetList(int index) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: attendanceList[index].leaveDates.length,
      itemBuilder: (context, ind) {
        return appliedAttendanceWidget(
            attendanceData: attendanceList[index], index: ind);
      },
    );
  }

  Widget appliedAttendanceWidget({AttendanceData? attendanceData, int? index}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width * .25,
                child: Text(
                  attendanceData!.leaveDates[index!].date ?? '',
                  style: const TextStyle(
                      fontSize: 14,
                      color: ColorConstant.blackColor,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width * .215,
                child: Text(
                  attendanceData.leaveDates[index].type ?? '',
                  style: const TextStyle(
                      fontSize: 14,
                      color: ColorConstant.blackColor,
                      fontWeight: FontWeight.w500),
                ),
              ),
              attendanceData.leaveDates[index].date == null
                  ? const SizedBox()
                  : Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width * .25,
                      child: Text(
                        DateFormat('EEEE').format(DateTime.parse(
                            attendanceData.leaveDates[index].date!)),
                        style: const TextStyle(
                            fontSize: 14,
                            color: ColorConstant.blackColor,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
              Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width * .23,
                child: Text(
                  attendanceData.leaveDates[index].status ?? '',
                  style: const TextStyle(
                      fontSize: 14,
                      color: ColorConstant.blackColor,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }
}

class Meeting {
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
}
