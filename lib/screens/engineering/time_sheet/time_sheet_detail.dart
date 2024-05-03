import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wikitek/models/time_sheet/time_sheet_model.dart';
import 'package:wikitek/screens/engineering/time_sheet/update_time_sheet_screen.dart';
import 'package:wikitek/utility/colors.dart';
import 'package:wikitek/widgets/app_bar_detail.dart';
import 'package:wikitek/widgets/common_button.dart';

class TimeSheetDetailScreen extends StatefulWidget {
  final TimeSheetData? data;
  const TimeSheetDetailScreen({super.key, this.data});

  @override
  State<TimeSheetDetailScreen> createState() => _TimeSheetDetailScreenState();
}

class _TimeSheetDetailScreenState extends State<TimeSheetDetailScreen> {
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              textFieldWidget(title: "Mon", time: widget.data!.mon ?? "O"),
              const SizedBox(
                height: 10,
              ),
              textFieldWidget(title: "Tue", time: widget.data!.tue ?? "O"),
              const SizedBox(
                height: 10,
              ),
              textFieldWidget(title: "wed", time: widget.data!.wed ?? "O"),
              const SizedBox(
                height: 10,
              ),
              textFieldWidget(title: "Thu", time: widget.data!.thu ?? "O"),
              const SizedBox(
                height: 10,
              ),
              textFieldWidget(title: "Fri", time: widget.data!.fri ?? "O"),
              const SizedBox(
                height: 10,
              ),
              textFieldWidget(title: "Sat", time: widget.data!.sat ?? "O"),
              const SizedBox(
                height: 10,
              ),
              textFieldWidget(title: "Sun", time: widget.data!.sun ?? "O"),
              const SizedBox(
                height: 40,
              ),
              CommonButton(
                onTap: () {
                  Get.to(
                    () => UpdateTimeSheetScreen(
                      data: widget.data,
                    ),
                  );
                },
                title: 'Update',
                width: MediaQuery.of(context).size.width,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget textFieldWidget({String? title, dynamic time}) {
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
          child: Container(
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
            child: Text(
              "$time Hour",
              style: const TextStyle(
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
}
