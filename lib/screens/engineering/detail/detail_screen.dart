import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wikitek/models/engineering/engineering_model.dart';
import 'package:wikitek/utility/colors.dart';
import 'package:wikitek/widgets/app_bar_detail.dart';
import 'package:wikitek/widgets/common_button.dart';

class DetailScreen extends StatefulWidget {
  final EngineeringData? engineeringData;
  const DetailScreen({super.key, this.engineeringData});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.backgroundColor,
      appBar: titleAppBarTitle(
        onTap: () {
          Navigator.pop(context);
        },
        context: context,
        title: 'Engineering',
        isAmount: false,
        subHeading: widget.engineeringData!.id,
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
                        title: 'SO ID',
                        heading: widget.engineeringData!.so?.id,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      commonRowDesign(
                        title: 'Client',
                        heading: widget.engineeringData!.client?.companyName,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      commonRowDesign(
                        title: 'Name',
                        heading: widget.engineeringData!.projectName,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      commonRowDesign(
                        title: 'Description',
                        heading: widget.engineeringData!.description,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      commonRowDesign(
                        title: 'Budget',
                        heading:
                            widget.engineeringData!.projectBudget.toString(),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      commonRowDesign(
                        title: 'Currency',
                        heading: widget.engineeringData!.budgetCurrency!
                            .toUpperCase(),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      commonRowDesign(
                        title: 'Project Manager',
                        heading: widget.engineeringData!.projectManager != null
                            ? widget.engineeringData!.projectManager
                                        ?.lastName !=
                                    null
                                ? widget.engineeringData!.projectManager!
                                        .firstName! +
                                    widget.engineeringData!.projectManager!
                                        .lastName!
                                : widget
                                    .engineeringData!.projectManager?.firstName
                            : "",
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      commonRowDesign(
                        title: 'Saleable',
                        heading: widget.engineeringData!.saleable!.toString(),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      commonRowDesign(
                        title: 'Status',
                        heading: widget.engineeringData!.status!.toString(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: CommonButton(
                  onTap: () async {
                    // var response = await Get.to(
                    //   () => UploadDocumentsScreen(leadData: salesData),
                    // );
                    // if (response != null) {
                    //   salesData = SalesLeadData.fromJson(jsonDecode(response));
                    //   setState(() {});
                    // }
                  },
                  title: 'Documents',
                  width: MediaQuery.of(context).size.width,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
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
