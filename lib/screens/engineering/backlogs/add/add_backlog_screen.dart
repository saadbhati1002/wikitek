import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wikitek/api/repository/engineering/engineering.dart';
import 'package:wikitek/models/common_model.dart';
import 'package:wikitek/models/engineering/engineering_model.dart';
import 'package:wikitek/utility/colors.dart';
import 'package:wikitek/utility/constant.dart';
import 'package:wikitek/widgets/app_bar_detail.dart';
import 'package:wikitek/widgets/common_button.dart';
import 'package:wikitek/widgets/common_text_fields.dart';
import 'package:wikitek/widgets/show_progress_bar.dart';

class AddBacklogScreen extends StatefulWidget {
  const AddBacklogScreen({super.key});

  @override
  State<AddBacklogScreen> createState() => _AddBacklogScreenState();
}

class _AddBacklogScreenState extends State<AddBacklogScreen> {
  String selectedEngineering = "Please Select Engineering";
  String? selectedStatus;
  String? selectedPriority;
  String? selectedProjectID;
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController type = TextEditingController();
  TextEditingController startData = TextEditingController();
  TextEditingController endDate = TextEditingController();
  List<EngineeringData> engineeringList = [];
  bool isLoading = false;

  @override
  void initState() {
    getLeads();
    super.initState();
  }

  getLeads() async {
    try {
      setState(() {
        isLoading = true;
      });
      engineeringList = [];
      EngineeringRes response =
          await EngineeringRepository().getEngineeringListApiCall();
      if (response.results!.isNotEmpty) {
        engineeringList = response.results!;
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
      appBar: titleAppBarTitle(
        context: context,
        onTap: () {
          Navigator.pop(context);
        },
        title: 'Engineering',
        isAmount: false,
        subHeading: "Add Projects",
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * .02,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: CustomTextFormField(
                      controller: title,
                      context: context,
                      hintText: 'Enter Title',
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .02,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: CustomTextFormField(
                      controller: description,
                      context: context,
                      isMaxLine: true,
                      hintText: 'Description',
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .02,
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 3),
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
                              color: selectedEngineering ==
                                      "Please Select Engineering"
                                  ? ColorConstant.greyDarkColor
                                  : ColorConstant.bottomSheetColor,
                              fontSize: 16,
                              fontWeight: selectedEngineering ==
                                      "Please Select Engineering"
                                  ? FontWeight.w400
                                  : FontWeight.w500,
                            ),
                          ),
                          onChanged: (value) {
                            selectedEngineering = value!.projectId!;
                            selectedProjectID = value.id;
                            setState(() {});
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .02,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: CustomTextFormField(
                      controller: type,
                      context: context,
                      hintText: 'Enter Type',
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .02,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 3),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          dropdownColor: ColorConstant.whiteColor,
                          icon: const Icon(
                            Icons.keyboard_arrow_down_sharp,
                            color: ColorConstant.greyDarkColor,
                          ),
                          isExpanded: true,
                          items: <String>[
                            'Work in process',
                            'complete',
                            'Hold',
                          ].map((String value) {
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
                            selectedStatus ?? "Status",
                            maxLines: 1,
                            style: TextStyle(
                              color: selectedStatus == null
                                  ? ColorConstant.greyDarkColor
                                  : ColorConstant.bottomSheetColor,
                              fontSize: 16,
                              fontWeight: selectedStatus == null
                                  ? FontWeight.w400
                                  : FontWeight.w500,
                            ),
                          ),
                          onChanged: (value) {
                            selectedStatus = value!;
                            setState(() {});
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .02,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 3),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          dropdownColor: ColorConstant.whiteColor,
                          icon: const Icon(
                            Icons.keyboard_arrow_down_sharp,
                            color: ColorConstant.greyDarkColor,
                          ),
                          isExpanded: true,
                          items: <String>[
                            '1',
                            '2',
                            '3',
                            '4',
                            '5',
                            '6',
                            '6',
                            '7',
                            '8',
                            '9',
                            '10',
                          ].map((String value) {
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
                            selectedPriority ?? "Select Priority",
                            maxLines: 1,
                            style: TextStyle(
                              color: selectedPriority == null
                                  ? ColorConstant.greyDarkColor
                                  : ColorConstant.bottomSheetColor,
                              fontSize: 16,
                              fontWeight: selectedPriority == null
                                  ? FontWeight.w400
                                  : FontWeight.w500,
                            ),
                          ),
                          onChanged: (value) {
                            selectedPriority = value!;
                            setState(() {});
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .02,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: CustomTextFormField(
                      onTap: () {
                        _selectStartDate(context);
                      },
                      controller: startData,
                      context: context,
                      hintText: 'Start Date/Time',
                      suffix: const Icon(Icons.calendar_month_outlined),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .02,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: CustomTextFormField(
                      onTap: () {
                        _selectEndDate(context);
                      },
                      controller: endDate,
                      context: context,
                      hintText: 'End Date/Time',
                      suffix: const Icon(Icons.calendar_month_outlined),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .035,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: CommonButton(
                    onTap: () {
                      _createBacklog();
                    },
                    title: 'Save',
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .035,
                ),
              ],
            ),
          ),
          isLoading ? const ShowProgressBar() : const SizedBox(),
        ],
      ),
    );
  }

  _selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      startData.text = DateFormat('yyyy-MM-dd').format(picked);
      setState(() {});
    }
    FocusManager.instance.primaryFocus?.unfocus();
  }

  _selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      endDate.text = DateFormat('yyyy-MM-dd').format(picked);
      setState(() {});
    }
    FocusManager.instance.primaryFocus?.unfocus();
  }

  Future _createBacklog() async {
    if (title.text.isEmpty) {
      toastShow(message: "Please enter title");
      return;
    }
    if (description.text.isEmpty) {
      toastShow(message: "Please enter description");
      return;
    }
    if (selectedProjectID == null) {
      toastShow(message: "Please select engineering");
      return;
    }
    if (type.text.isEmpty) {
      toastShow(message: "Please enter type");
      return;
    }
    if (selectedStatus == null) {
      toastShow(message: "Please select status");
      return;
    }
    if (selectedPriority == null) {
      toastShow(message: "Please select priority");
      return;
    }
    if (startData.text.isEmpty) {
      toastShow(message: "Please select start date");
      return;
    }
    if (endDate.text.isEmpty) {
      toastShow(message: "Please select end date");
      return;
    }
    try {
      setState(() {
        isLoading = true;
      });
      CommonRes response = await EngineeringRepository().createBacklogApiCall(
        backlogTitle: title.text.trim(),
        description: description.text.trim(),
        priority: selectedPriority,
        projectID: selectedProjectID,
        remark: type.text.trim(),
        status: selectedStatus,
        targetDate: endDate.text.trim(),
      );
      if (response.success == true) {
        toastShow(message: "Backlog created successfully");
        Get.back();
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
