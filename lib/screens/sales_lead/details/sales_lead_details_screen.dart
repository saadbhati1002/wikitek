import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wikitek/api/repository/sales_lead/sales_lead.dart';
import 'package:wikitek/models/common_model.dart';
import 'package:wikitek/models/lead/lead_model.dart';
import 'package:wikitek/utility/colors.dart';
import 'package:wikitek/utility/constant.dart';
import 'package:wikitek/widgets/app_bar_title.dart';
import 'package:wikitek/widgets/common_button.dart';

class SalesLeadDetailsScreen extends StatefulWidget {
  final SalesLeadData? leadData;
  const SalesLeadDetailsScreen({super.key, this.leadData});

  @override
  State<SalesLeadDetailsScreen> createState() => _SalesLeadDetailsScreenState();
}

class _SalesLeadDetailsScreenState extends State<SalesLeadDetailsScreen> {
  bool isLoading = false;
  SalesLeadData? salesData;
  @override
  void initState() {
    salesData = widget.leadData;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.backgroundColor,
      appBar: titleAppBar(
          onTap: () {
            Navigator.pop(context);
          },
          context: context,
          title: 'Sales - Lead',
          amount: salesData!.total ?? ''),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Material(
                borderRadius: BorderRadius.circular(5),
                elevation: 1,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  decoration: BoxDecoration(
                    color: ColorConstant.whiteColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Column(
                    children: [
                      commonRowDesign(
                        title: 'ORG',
                        heading: salesData!.org!.companyName ?? "",
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      commonRowDesign(
                        title: 'SL ID',
                        heading: salesData!.leadId ?? "",
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      commonRowDesign(
                        title: 'Client',
                        heading: salesData!.client!.companyName ?? "",
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      commonRowDesign(
                        title: 'Description',
                        heading: salesData!.description ?? "",
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      commonRowDesign(
                        title: 'Exp PO Date',
                        heading: salesData!.expectedDate ?? "",
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      commonRowDesign(
                        title: 'Exp Inv Date',
                        heading: salesData!.expectedInvoiceDate ?? "",
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      commonRowDesign(
                        title: 'Department',
                        heading: salesData!.department?.name ?? "",
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      commonRowDesign(
                        title: 'Status',
                        heading: salesData!.status ?? "",
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      commonRowDesign(
                          title: 'Contact Name',
                          heading: salesData!.contactName ?? ""),
                      const SizedBox(
                        height: 15,
                      ),
                      commonRowDesign(
                        title: 'Mobile No',
                        heading: salesData!.mobile ?? "",
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      commonRowDesign(
                        title: 'Probability',
                        heading: salesData!.probability.toString(),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CommonButton(
                        onTap: () {},
                        title: 'Add Part',
                        width: MediaQuery.of(context).size.width,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            salesData!.parts == null
                ? const SizedBox()
                : ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    itemCount: salesData!.parts!.length,
                    itemBuilder: (context, index) {
                      return leadNotesWidget(index);
                    },
                  ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget leadNotesWidget(index) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * .85,
            child: Material(
              elevation: 1,
              borderRadius: BorderRadius.circular(5),
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                decoration: BoxDecoration(
                  color: ColorConstant.whiteColor,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          width: MediaQuery.of(context).size.width * .5,
                          child: Text(
                            salesData!.parts![index].partId!.partNumber ?? '',
                            maxLines: 1,
                            style: const TextStyle(
                                fontSize: 14,
                                fontFamily: "roboto",
                                color: ColorConstant.greyDarkColor,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        Container(
                          alignment: Alignment.topRight,
                          width: MediaQuery.of(context).size.width * .265,
                          child: Text(
                            salesData!.parts![index].expdGrossPrice ?? '',
                            maxLines: 1,
                            style: const TextStyle(
                                fontSize: 14,
                                fontFamily: "roboto",
                                color: ColorConstant.greyDarkColor,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          width: MediaQuery.of(context).size.width * .52,
                          child: Text(
                            salesData!.parts![index].shortDescription ?? '',
                            maxLines: 1,
                            style: const TextStyle(
                                fontSize: 14,
                                fontFamily: "roboto",
                                color: ColorConstant.greyDarkColor,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        Container(
                          alignment: Alignment.topRight,
                          width: MediaQuery.of(context).size.width * .2,
                          child: Text(
                            salesData!.parts![index].status ?? '',
                            maxLines: 1,
                            style: const TextStyle(
                                fontSize: 14,
                                fontFamily: "roboto",
                                color: ColorConstant.greyDarkColor,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              deletePartPopUP(index: index);
            },
            child: const FaIcon(
              FontAwesomeIcons.xmark,
              color: ColorConstant.redColor,
            ),
          )
        ],
      ),
    );
  }

  Widget commonRowDesign({String? title, String? heading}) {
    return SizedBox(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * .27,
            child: Text(
              "$title:",
              style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  fontFamily: "roboto",
                  color: ColorConstant.blackColor),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * .575,
            child: Text(
              heading!,
              style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                  fontFamily: "roboto",
                  color: ColorConstant.greyTextColor),
            ),
          )
        ],
      ),
    );
  }

  void deletePartPopUP({int? index}) async {
    return showDialog(
      context: context,
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              shape: const RoundedRectangleBorder(
                  side: BorderSide(color: ColorConstant.greyColor),
                  borderRadius: BorderRadius.all(
                    Radius.circular(15.0),
                  )),
              elevation: 0,
              backgroundColor: ColorConstant.whiteColor,
              actionsPadding: const EdgeInsets.symmetric(vertical: 0),
              title: Container(
                alignment: Alignment.topLeft,
                decoration: BoxDecoration(
                    color: ColorConstant.whiteColor,
                    borderRadius: BorderRadius.circular(15)),
                // height: MediaQuery.of(context).size.height * .25,
                width: MediaQuery.of(context).size.width * .7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Are you sure?',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: ColorConstant.blackColor,
                        fontSize: 18,
                        fontFamily: 'inter',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 13,
                    ),
                    const Text(
                      'Do you want to delete this part?',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: ColorConstant.blackColor,
                        fontSize: 14,
                        fontFamily: 'inter',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: ColorConstant.mainColor,
                                borderRadius: BorderRadius.circular(8)),
                            height: 35,
                            // width: MediaQuery.of(context).size.width * .2,
                            alignment: Alignment.center,
                            child: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: Text(
                                'No',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: ColorConstant.whiteColor),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            deleteSalesLead(index: index);
                            Navigator.pop(context);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: ColorConstant.mainColor,
                                borderRadius: BorderRadius.circular(8)),
                            height: 35,
                            // width: MediaQuery.of(context).size.width * .2,
                            alignment: Alignment.center,
                            child: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: Text(
                                'Yes',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: ColorConstant.whiteColor),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  deleteSalesLead({int? index}) async {
    try {
      setState(() {
        isLoading = true;
      });
      CommonRes response = await SalesLeadRepository()
          .salesLeadUpdateApiCall(data: salesData, index: index);
      if (response.success == true) {
        toastShow(message: "Deleted Successfully");
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
