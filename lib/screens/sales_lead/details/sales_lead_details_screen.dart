import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wikitek/models/lead/lead_model.dart';
import 'package:wikitek/utility/colors.dart';
import 'package:wikitek/widgets/app_bar_title.dart';
import 'package:wikitek/widgets/common_button.dart';

class SalesLeadDetailsScreen extends StatefulWidget {
  final SalesLeadData? leadData;
  const SalesLeadDetailsScreen({super.key, this.leadData});

  @override
  State<SalesLeadDetailsScreen> createState() => _SalesLeadDetailsScreenState();
}

class _SalesLeadDetailsScreenState extends State<SalesLeadDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.backgroundColor,
      appBar: titleAppBar(
        context: context,
        title: 'Sales - Lead',
      ),
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
                        heading: widget.leadData!.org!.companyName ?? "",
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      commonRowDesign(
                        title: 'SL ID',
                        heading: widget.leadData!.leadId ?? "",
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      commonRowDesign(
                        title: 'Client',
                        heading: widget.leadData!.client!.companyName ?? "",
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      commonRowDesign(
                        title: 'Description',
                        heading: widget.leadData!.description ?? "",
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      commonRowDesign(
                        title: 'Exp PO Date',
                        heading: widget.leadData!.expectedDate ?? "",
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      commonRowDesign(
                        title: 'Exp Inv Date',
                        heading: widget.leadData!.expectedInvoiceDate ?? "",
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      commonRowDesign(
                        title: 'Department',
                        heading: widget.leadData!.department!.name ?? "",
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      commonRowDesign(
                        title: 'Status',
                        heading: widget.leadData!.status ?? "",
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      commonRowDesign(
                          title: 'Contact Name',
                          heading: widget.leadData!.contactName ?? ""),
                      const SizedBox(
                        height: 15,
                      ),
                      commonRowDesign(
                        title: 'Mobile No',
                        heading: widget.leadData!.mobile ?? "",
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      commonRowDesign(
                        title: 'Probability',
                        heading: widget.leadData!.probability.toString(),
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
            widget.leadData!.parts == null
                ? const SizedBox()
                : ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    itemCount: widget.leadData!.parts!.length,
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
                            widget.leadData!.parts![index].partId!.partNumber ??
                                '',
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
                            widget.leadData!.parts![index].expdGrossPrice ?? '',
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
                            widget.leadData!.parts![index].shortDescription ??
                                '',
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
                            widget.leadData!.parts![index].status ?? '',
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
          const FaIcon(
            FontAwesomeIcons.xmark,
            color: ColorConstant.redColor,
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
}
