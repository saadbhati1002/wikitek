import 'package:flutter/material.dart';
import 'package:wikitek/api/repository/engineering/engineering.dart';
import 'package:wikitek/models/common_model.dart';
import 'package:wikitek/models/time_sheet/time_sheet_model.dart';
import 'package:wikitek/utility/colors.dart';
import 'package:wikitek/utility/constant.dart';
import 'package:wikitek/widgets/app_bar_detail.dart';
import 'package:wikitek/widgets/common_button.dart';
import 'package:wikitek/widgets/common_text_fields.dart';
import 'package:wikitek/widgets/show_progress_bar.dart';

class UpdateTimeSheetScreen extends StatefulWidget {
  final TimeSheetData? data;
  const UpdateTimeSheetScreen({super.key, this.data});

  @override
  State<UpdateTimeSheetScreen> createState() => _UpdateTimeSheetScreenState();
}

class _UpdateTimeSheetScreenState extends State<UpdateTimeSheetScreen> {
  TextEditingController mondayController = TextEditingController();
  TextEditingController tuesdayController = TextEditingController();
  TextEditingController wednesdayController = TextEditingController();
  TextEditingController thursdayController = TextEditingController();
  TextEditingController fridayController = TextEditingController();
  TextEditingController saturdayController = TextEditingController();
  TextEditingController sundayController = TextEditingController();
  bool isLoading = false;
  @override
  void initState() {
    _checkData();
    super.initState();
  }

  _checkData() async {
    if (widget.data!.mon != null && widget.data!.mon != "") {
      mondayController.text = widget.data!.mon.toString();
    }
    if (widget.data!.tue != null && widget.data!.tue != "") {
      tuesdayController.text = widget.data!.tue.toString();
    }
    if (widget.data!.wed != null && widget.data!.wed != "") {
      wednesdayController.text = widget.data!.wed.toString();
    }
    if (widget.data!.thu != null && widget.data!.thu != "") {
      thursdayController.text = widget.data!.thu.toString();
    }
    if (widget.data!.fri != null && widget.data!.fri != "") {
      fridayController.text = widget.data!.fri.toString();
    }
    if (widget.data!.sat != null && widget.data!.sat != "") {
      saturdayController.text = widget.data!.sat.toString();
    }
    if (widget.data!.sun != null && widget.data!.sun != "") {
      sundayController.text = widget.data!.sun.toString();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: titleAppBarTitle(
        context: context,
        onTap: () {
          Navigator.pop(context);
        },
        title: widget.data!.project!.projectName ?? "",
        isAmount: false,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  textFieldWidget(
                      title: "Mon", textController: mondayController),
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
                  textFieldWidget(
                      title: "Fri", textController: fridayController),
                  const SizedBox(
                    height: 10,
                  ),
                  textFieldWidget(
                      title: "Sat", textController: saturdayController),
                  const SizedBox(
                    height: 10,
                  ),
                  textFieldWidget(
                      title: "Sun", textController: sundayController),
                  const SizedBox(
                    height: 30,
                  ),
                  CommonButton(
                    onTap: () {
                      _updateTimeSheet();
                    },
                    title: 'Update',
                    width: MediaQuery.of(context).size.width,
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
            child: CustomTextFormField(
              keyboardType: TextInputType.number,
              controller: textController,
              context: context,
              hintText: 'Hours',
            ))
      ],
    );
  }

  Future _updateTimeSheet() async {
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
    try {
      setState(() {
        isLoading = true;
      });
      CommonRes response = await EngineeringRepository().updateTimeSheetApiCall(
        timeSheetTd: widget.data!.project!.id,
        friday: fridayController.text.trim(),
        monday: mondayController.text.trim(),
        projectID: widget.data!.id,
        saturday: saturdayController.text.trim(),
        sunday: sundayController.text.trim(),
        thursday: thursdayController.text.trim(),
        tuesday: tuesdayController.text.trim(),
        wednesday: wednesdayController.text.trim(),
        week: widget.data!.week.toString(),
      );
      if (response.success == true) {
        toastShow(message: "TimeSheet updated successfully");
      } else {
        toastShow(message: "Getting some error. Please try again");
      }
    } catch (e) {
      toastShow(message: "We are facing some issue. Please try again");
      debugPrint(e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}
