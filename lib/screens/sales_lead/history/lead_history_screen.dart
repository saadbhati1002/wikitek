import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:wikitek/api/repository/sales_lead/sales_lead.dart';
import 'package:wikitek/models/lead/history/sales_history_model.dart';
import 'package:wikitek/models/lead/lead_model.dart';
import 'package:wikitek/utility/colors.dart';
import 'package:wikitek/utility/constant.dart';
import 'package:wikitek/widgets/app_bar_title.dart';
import 'package:wikitek/widgets/common_button.dart';
import 'package:wikitek/widgets/common_text_fields.dart';
import 'package:wikitek/widgets/show_progress_bar.dart';

class LeadHistoryScreen extends StatefulWidget {
  final SalesLeadData? leadData;

  const LeadHistoryScreen({super.key, this.leadData});

  @override
  State<LeadHistoryScreen> createState() => _LeadHistoryScreenState();
}

class _LeadHistoryScreenState extends State<LeadHistoryScreen> {
  TextEditingController comment = TextEditingController();
  bool isLoading = false;
  bool isAddHistory = false;
  Future<bool> willPopScope() {
    Navigator.pop(context, jsonEncode(widget.leadData));

    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: willPopScope,
      child: Scaffold(
        backgroundColor: ColorConstant.backgroundColor,
        appBar: titleAppBar(
          isHome: false,
          onTap: () {
            Navigator.pop(context, jsonEncode(widget.leadData));
          },
          context: context,
          title: 'Sales - Lead',
          amount: "",
          isAmount: false,
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "History",
                          maxLines: 1,
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: "roboto",
                              color: ColorConstant.bottomSheetColor,
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .35,
                          child: CommonButton(
                            onTap: () {
                              setState(() {
                                isAddHistory = true;
                              });
                            },
                            title: 'Update',
                            width: MediaQuery.of(context).size.width,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: widget.leadData?.salesLeadHistory?.length,
                    itemBuilder: (context, index) {
                      return historyWidget(
                          index: index,
                          historyData:
                              widget.leadData?.salesLeadHistory?[index]);
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
            isAddHistory == true ? addHistory() : const SizedBox(),
            isLoading ? const ShowProgressBar() : const SizedBox(),
          ],
        ),
      ),
    );
  }

  Widget historyWidget({index, SalesLeadHistory? historyData}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              commonRowDesign(
                title: "Name",
                heading: historyData!.createdBy?.firstName,
                isBold: true,
              ),
              const SizedBox(
                height: 7,
              ),
              commonRowDesign(
                title: "Email",
                heading: historyData.createdBy?.email,
                isBold: true,
              ),
              const SizedBox(
                height: 7,
              ),
              commonRowDesign(
                title: "Mobile",
                heading: historyData.createdBy?.mobile,
                isBold: true,
              ),
              const SizedBox(
                height: 7,
              ),
              commonRowDesign(
                title: "Date",
                heading: historyData.date,
                isBold: true,
              ),
              const SizedBox(
                height: 7,
              ),
              Text(
                historyData.comment ?? "",
                textAlign: TextAlign.left,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  fontFamily: "roboto",
                  color: ColorConstant.blackColor,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget commonRowDesign({String? title, String? heading, bool? isBold}) {
    return SizedBox(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * .27,
            child: Text(
              "$title:",
              style: TextStyle(
                  fontWeight:
                      isBold == true ? FontWeight.w600 : FontWeight.w500,
                  fontSize: 15,
                  fontFamily: "roboto",
                  color: ColorConstant.blackColor),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * .575,
            child: Text(
              heading ?? "",
              style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  fontFamily: "roboto",
                  color: ColorConstant.greyTextColor),
            ),
          )
        ],
      ),
    );
  }

  Widget addHistory() {
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
          height: MediaQuery.of(context).size.height * .47,
          child: Column(
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
                      "Add Part",
                      maxLines: 1,
                      style: TextStyle(
                          fontSize: 18,
                          fontFamily: "roboto",
                          color: ColorConstant.bottomSheetColor,
                          fontWeight: FontWeight.w700),
                    ),
                    GestureDetector(
                      onTap: () {
                        isAddHistory = false;
                        comment.clear();

                        setState(() {});
                      },
                      child: const FaIcon(
                        FontAwesomeIcons.xmark,
                        color: ColorConstant.redColor,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 0.5,
                color: ColorConstant.greyBlueColor,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .022,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: CustomTextFormField(
                  context: context,
                  isMaxLine: true,
                  controller: comment,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .019,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: CommonButton(
                  onTap: () {
                    _addSalesHistory();
                  },
                  title: 'Add History',
                  width: MediaQuery.of(context).size.width,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _addSalesHistory({int? index}) async {
    if (comment.text.isEmpty) {
      toastShow(message: "Please add comment to add history.");
      return;
    }
    try {
      setState(() {
        isAddHistory = false;
        isLoading = true;
      });
      FocusManager.instance.primaryFocus?.unfocus();
      SalesHistoryRes response =
          await SalesLeadRepository().addSalesHistoryApiCall(
        comment: comment.text.toString().trim(),
        date: DateFormat('yyyy-MM-dd').format(DateTime.now()),
        salesLead: widget.leadData!.leadNo,
      );
      if (response.success == true) {
        widget.leadData!.salesLeadHistory!.add(
          SalesLeadHistory(
              comment: comment.text.toString().trim(),
              createdBy: CreatedBy(
                email: AppConstant.userData?.email,
                firstName: AppConstant.userData?.firstName,
                id: AppConstant.userData?.userId,
                lastName: AppConstant.userData?.lastName,
                mobile: AppConstant.userData?.mobile,
              ),
              date: DateFormat('yyyy-MM-dd').format(DateTime.now()).toString(),
              id: response.id),
        );
        widget
            .leadData!
            .salesLeadHistory![widget.leadData!.salesLeadHistory!.length - 1]
            .comment = comment.text.toString().trim();
        widget
            .leadData!
            .salesLeadHistory![widget.leadData!.salesLeadHistory!.length - 1]
            .date = DateFormat('yyyy-MM-dd').format(DateTime.now()).toString();
        widget
            .leadData!
            .salesLeadHistory![widget.leadData!.salesLeadHistory!.length - 1]
            .id = response.id;

        widget
            .leadData!
            .salesLeadHistory![widget.leadData!.salesLeadHistory!.length - 1]
            .createdBy!
            .email = AppConstant.userData!.email;
        widget
            .leadData!
            .salesLeadHistory![widget.leadData!.salesLeadHistory!.length - 1]
            .createdBy!
            .mobile = AppConstant.userData!.mobile;
        widget
            .leadData!
            .salesLeadHistory![widget.leadData!.salesLeadHistory!.length - 1]
            .createdBy!
            .firstName = AppConstant.userData!.firstName;
        widget
            .leadData!
            .salesLeadHistory![widget.leadData!.salesLeadHistory!.length - 1]
            .createdBy!
            .lastName = AppConstant.userData!.lastName;
        comment.clear();
        setState(() {});
        toastShow(message: "Add Successfully");
      } else {
        toastShow(
            message: "Getting some error. Please try after some time later");
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
