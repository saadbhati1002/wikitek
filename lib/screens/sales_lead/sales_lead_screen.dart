import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';
import 'package:wikitek/api/repository/sales_lead/sales_lead.dart';
import 'package:wikitek/models/lead/lead_model.dart';

import 'package:wikitek/utility/colors.dart';
import 'package:wikitek/utility/constant.dart';
import 'package:wikitek/widgets/app_bar_title.dart';
import 'package:wikitek/widgets/sales_lead_widget.dart';

class SalesLeadScreen extends StatefulWidget {
  const SalesLeadScreen({super.key});

  @override
  State<SalesLeadScreen> createState() => _SalesLeadScreenState();
}

class _SalesLeadScreenState extends State<SalesLeadScreen> {
  String? salesLeadYear = "2023 - 2024";
  List<SalesLeadData> salesLead = [];
  List<SalesLeadData> allSalesLead = [];
  int? filterIndex = 1;
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
      salesLead = [];
      SalesLeadRes response =
          await SalesLeadRepository().salesLeadApiCall(year: salesLeadYear);
      if (response.results!.isNotEmpty) {
        allSalesLead = response.results!;
        salesLead = response.results!;
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
      backgroundColor: ColorConstant.backgroundColor,
      appBar: titleAppBar(
        context: context,
        title: 'Sales - Lead',
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(
            height: 45,
            color: ColorConstant.mainColor,
            child: Row(
              children: [
                tabBarTitle(
                  index: 0,
                  title: "By Client",
                  onTap: () {
                    setState(() {
                      filterIndex = 0;
                    });
                  },
                ),
                tabBarTitle(
                  index: 1,
                  title: "By Dept",
                  onTap: () {
                    setState(() {
                      filterIndex = 1;
                    });
                  },
                ),
                tabBarTitle(
                  index: 2,
                  title: "By Year",
                  onTap: () {
                    setState(() {
                      filterIndex = 2;
                    });
                    filterYearBottomSheet(context: context);
                  },
                ),
              ],
            ),
          ),
          isLoading
              ? ListView.builder(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  itemCount: 10,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return leadSkelton();
                  },
                )
              : salesLead.isEmpty
                  ? SizedBox(
                      height: MediaQuery.of(context).size.height * .77,
                      child: const Center(
                        child: Text(
                          "No Leads Found",
                          style: TextStyle(
                              fontSize: 16,
                              color: ColorConstant.blackColor,
                              fontFamily: "roboto",
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: salesLead.length,
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 15),
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return salesLeadWidget(
                            context: context, leadData: salesLead[index]);
                      },
                    ),
        ],
      )),
    );
  }

  Widget leadSkelton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Material(
        elevation: 2,
        borderRadius: BorderRadius.circular(10),
        shadowColor: ColorConstant.mainColor,
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 0.9, color: ColorConstant.mainColor),
          ),
          child: SkeletonTheme(
            themeMode: ThemeMode.light,
            child: SkeletonAvatar(
              style: SkeletonAvatarStyle(
                  height: 100, width: MediaQuery.of(context).size.width),
            ),
          ),
        ),
      ),
    );
  }

  Widget tabBarTitle({String? title, int? index, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap!,
      child: Container(
        height: 45,
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width * .33,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Text(
              title!,
              style: TextStyle(
                  fontSize: 16,
                  fontFamily: "roboto",
                  fontWeight:
                      index == filterIndex ? FontWeight.bold : FontWeight.w500,
                  color: index == filterIndex
                      ? ColorConstant.whiteColor
                      : ColorConstant.greyColor),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: index == filterIndex
                    ? ColorConstant.whiteColor
                    : ColorConstant.mainColor,
                height: 2,
                width: MediaQuery.of(context).size.width * .33,
              ),
            )
          ],
        ),
      ),
    );
  }

  filterYearBottomSheet({BuildContext? context}) {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context!,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context,
              StateSetter setState /*You can rename this!*/) {
            return Container(
              decoration: const BoxDecoration(
                color: ColorConstant.mainColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              height: MediaQuery.of(context).size.height * .5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    height: MediaQuery.of(context).size.height * .075,
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      "Select Year",
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: "roboto",
                          color: ColorConstant.whiteColor,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      color: ColorConstant.whiteColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    height: MediaQuery.of(context).size.height * .425,
                    child: SingleChildScrollView(
                      child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: AppConstant.filterYears.length,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                salesLeadYear = AppConstant.filterYears[index];
                                getLeads();
                                Navigator.pop(context);
                              },
                              child: Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Row(
                                  children: [
                                    Icon(
                                      salesLeadYear ==
                                              AppConstant.filterYears[index]
                                          ? Icons.check_box
                                          : Icons
                                              .check_box_outline_blank_outlined,
                                      size: 25,
                                      color: ColorConstant.mainColor,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      AppConstant.filterYears[index],
                                      style: const TextStyle(
                                          fontSize: 14,
                                          color: ColorConstant.blackColor,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: "roboto"),
                                    )
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }
}
