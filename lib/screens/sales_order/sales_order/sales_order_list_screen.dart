import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletons/skeletons.dart';
import 'package:wikitek/api/repository/sales_order/sales_order.dart';
import 'package:wikitek/models/sales_order/sales_order_model.dart';
import 'package:wikitek/screens/dashboard/dashboard_screen.dart';
import 'package:wikitek/screens/sales_order/add/sales_order_add_screen.dart';

import 'package:wikitek/screens/sales_order/detail/sales_order_detail_screen.dart';

import 'package:wikitek/utility/colors.dart';
import 'package:wikitek/utility/constant.dart';
import 'package:wikitek/widgets/app_bar_title.dart';
import 'package:wikitek/widgets/common_button.dart';
import 'package:wikitek/widgets/sales_order_list_widget.dart';

class SalesOrderListScreen extends StatefulWidget {
  const SalesOrderListScreen({super.key});

  @override
  State<SalesOrderListScreen> createState() => _SalesOrderListScreenState();
}

class _SalesOrderListScreenState extends State<SalesOrderListScreen> {
  String? salesOrderYear = "2023 - 2024";
  List<Org> selectedClientID = [];
  List<Department> departmentSelected = [];
  List<SalesOrderData> salesOrder = [];
  List<SalesOrderData> allSalesOrder = [];
  List<Org> clientListForFilter = [];
  List<Department> departmentListForFilter = [];
  int? filterIndex;
  bool isLoading = false;
  @override
  void initState() {
    getSalesOrder();
    super.initState();
  }

  getSalesOrder() async {
    try {
      setState(() {
        isLoading = true;
      });
      salesOrder = [];
      allSalesOrder = [];
      departmentListForFilter = [];
      clientListForFilter = [];
      SalesOrderRes response =
          await SalesOrderRepository().salesOrderApiCall(year: salesOrderYear);
      if (response.results!.isNotEmpty) {
        allSalesOrder = response.results!;
        salesOrder = response.results!;
        getClient();
        getDepartment();
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  getClient() {
    for (int leadCount = 0; leadCount < allSalesOrder.length; leadCount++) {
      if (allSalesOrder[leadCount].client != null) {
        var contain = clientListForFilter.where((element) =>
            element.id.toString() ==
            allSalesOrder[leadCount].client!.id.toString());
        if (contain.isEmpty) {
          clientListForFilter.add(allSalesOrder[leadCount].client!);
        }
      }
    }
  }

  getDepartment() {
    for (int leadCount = 0; leadCount < allSalesOrder.length; leadCount++) {
      if (allSalesOrder[leadCount].department != null) {
        var contain = departmentListForFilter.where((element) =>
            element.id.toString() ==
            allSalesOrder[leadCount].department!.id.toString());
        if (contain.isEmpty) {
          departmentListForFilter.add(allSalesOrder[leadCount].department!);
        }
      }
    }
  }

  filterLeadForClient() {
    salesOrder = [];
    for (int leadCount = 0; leadCount < allSalesOrder.length; leadCount++) {
      if (allSalesOrder[leadCount].client != null) {
        for (int selectedCount = 0;
            selectedCount < selectedClientID.length;
            selectedCount++) {
          if (allSalesOrder[leadCount].client!.id.toString() ==
              selectedClientID[selectedCount].id.toString()) {
            salesOrder.add(allSalesOrder[leadCount]);
          }
        }
      }
    }
    setState(() {});
  }

  filterLeadForDepartment() {
    salesOrder = [];
    for (int leadCount = 0; leadCount < allSalesOrder.length; leadCount++) {
      if (allSalesOrder[leadCount].department != null) {
        for (int selectedCount = 0;
            selectedCount < departmentSelected.length;
            selectedCount++) {
          if (allSalesOrder[leadCount].department!.id.toString() ==
              departmentSelected[selectedCount].id.toString()) {
            salesOrder.add(allSalesOrder[leadCount]);
          }
        }
      }
    }
    setState(() {});
  }

  getTotalAmount() {
    double localAmount = 0.0;
    for (int leadCount = 0; leadCount < salesOrder.length; leadCount++) {
      localAmount = localAmount + double.parse(salesOrder[leadCount].total!);
    }
    return localAmount.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.backgroundColor,
      appBar: titleAppBar(
        isHome: true,
        onTap: () {
          Get.to(() => const DashBoardScreen());
        },
        context: context,
        title: 'Sales - Order',
        amount: getTotalAmount(),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 55),
        child: GestureDetector(
          onTap: () async {
            var response = await Get.to(
              () => const SalesOrderAddScreen(),
            );
            if (response == 1) {
              getSalesOrder();
            }
          },
          child: Container(
            height: 50,
            width: 50,
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: ColorConstant.mainColor),
            child: const Icon(
              Icons.add,
              color: ColorConstant.whiteColor,
              size: 30,
            ),
          ),
        ),
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
                      filterClientBottomSheet(context: context);
                      departmentSelected = [];
                      setState(() {
                        filterIndex = 0;
                      });
                    },
                  ),
                  tabBarTitle(
                    index: 1,
                    title: "By Dept",
                    onTap: () {
                      filterDepartmentBottomSheet(context: context);
                      selectedClientID = [];

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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    itemCount: 10,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return leadSkelton();
                    },
                  )
                : salesOrder.isEmpty
                    ? SizedBox(
                        height: MediaQuery.of(context).size.height * .77,
                        child: const Center(
                          child: Text(
                            "No Sales Order  Found",
                            style: TextStyle(
                                fontSize: 16,
                                color: ColorConstant.blackColor,
                                fontFamily: "roboto",
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: salesOrder.length,
                        shrinkWrap: true,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 15),
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Get.to(
                                () => SalesOrderDetailScreen(
                                  orderData: salesOrder[index],
                                ),
                              );
                            },
                            child: salesOrderListWidget(
                                context: context, leadData: salesOrder[index]),
                          );
                        },
                      ),
            const SizedBox(
              height: 60,
            ),
          ],
        ),
      ),
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
                                salesOrderYear = AppConstant.filterYears[index];
                                getSalesOrder();
                                Navigator.pop(context);
                              },
                              child: Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Row(
                                  children: [
                                    Icon(
                                      salesOrderYear ==
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

  filterClientBottomSheet({BuildContext? context}) {
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
              height: MediaQuery.of(context).size.height * .62,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    height: MediaQuery.of(context).size.height * .08,
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      "Select Client",
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
                    height: MediaQuery.of(context).size.height * .54,
                    child: Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .48,
                          child: SingleChildScrollView(
                            child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: clientListForFilter.length,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      if (clientListForFilter[index]
                                              .isSelected ==
                                          true) {
                                        clientListForFilter[index].isSelected =
                                            false;
                                        selectedClientID
                                            .remove(clientListForFilter[index]);
                                      } else {
                                        clientListForFilter[index].isSelected =
                                            true;
                                        selectedClientID
                                            .add(clientListForFilter[index]);
                                      }
                                      setState(
                                        () {},
                                      );
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      child: Row(
                                        children: [
                                          Icon(
                                            clientListForFilter[index]
                                                        .isSelected ==
                                                    true
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
                                            clientListForFilter[index]
                                                    .companyName ??
                                                '',
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
                        ),
                        Container(
                          color: Colors.transparent,
                          height: MediaQuery.of(context).size.height * .05,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: CommonButton(
                              onTap: () {
                                filterLeadForClient();
                                Navigator.pop(context);
                              },
                              title: 'Search',
                              width: MediaQuery.of(context).size.width,
                            ),
                          ),
                        )
                      ],
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

  filterDepartmentBottomSheet({BuildContext? context}) {
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
              height: MediaQuery.of(context).size.height * .62,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    height: MediaQuery.of(context).size.height * .08,
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      "Select Department",
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
                    height: MediaQuery.of(context).size.height * .54,
                    child: Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .48,
                          child: SingleChildScrollView(
                            child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: departmentListForFilter.length,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      if (departmentListForFilter[index]
                                              .isSelected ==
                                          true) {
                                        departmentListForFilter[index]
                                            .isSelected = false;
                                        departmentSelected.remove(
                                            departmentListForFilter[index]);
                                      } else {
                                        departmentListForFilter[index]
                                            .isSelected = true;
                                        departmentSelected.add(
                                            departmentListForFilter[index]);
                                      }
                                      setState(
                                        () {},
                                      );
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      child: Row(
                                        children: [
                                          Icon(
                                            departmentListForFilter[index]
                                                        .isSelected ==
                                                    true
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
                                            departmentListForFilter[index]
                                                    .name ??
                                                '',
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
                        ),
                        Container(
                          color: Colors.transparent,
                          height: MediaQuery.of(context).size.height * .05,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: CommonButton(
                              onTap: () {
                                filterLeadForDepartment();
                                Navigator.pop(context);
                              },
                              title: 'Search',
                              width: MediaQuery.of(context).size.width,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
