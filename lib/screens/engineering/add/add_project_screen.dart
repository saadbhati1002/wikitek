import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wikitek/api/repository/engineering/engineering.dart';
import 'package:wikitek/api/repository/sales_order/sales_order.dart';
import 'package:wikitek/api/repository/user/user.dart';
import 'package:wikitek/models/common_model.dart';
import 'package:wikitek/models/sales_order/sales_order_model.dart';
import 'package:wikitek/screens/dashboard/engineering/engineering_dashboard_screen.dart';
import 'package:wikitek/utility/colors.dart';
import 'package:wikitek/utility/constant.dart';
import 'package:wikitek/widgets/app_bar_detail.dart';
import 'package:wikitek/widgets/common_button.dart';
import 'package:wikitek/widgets/common_text_fields.dart';
import 'package:wikitek/models/user/user_model.dart' as user;
import 'package:wikitek/widgets/show_progress_bar.dart';

class AddEngineeringScreen extends StatefulWidget {
  const AddEngineeringScreen({super.key});

  @override
  State<AddEngineeringScreen> createState() => _AddEngineeringScreenState();
}

class _AddEngineeringScreenState extends State<AddEngineeringScreen> {
  TextEditingController projectName = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController projectBudget = TextEditingController();
  String? salesOrderYear = "2023 - 2024";
  List<SalesOrderData> salesOrder = [];
  List<SalesOrderData> salesOrderAll = [];
  List<Org> clientList = [];
  String salesOrderName = "Select Sales Order";
  String selectedClient = "Please Select Client";
  String? selectedCurrency;
  String selectedProjectManager = "Please Select Project Manager";
  String selectedSaleable = "Saleable";
  bool? isSaleable;
  String? selectedStatus;
  String? currency;
  List<user.UserData> userList = [];

  bool isLoading = false;
  String? selectedSalesOrderID;
  String? selectedClientID;
  String? selectedUserID;
  @override
  void initState() {
    _getData();
    super.initState();
  }

  _getData() async {
    try {
      setState(() {
        isLoading = true;
      });
      await _getSalesOrder();
      await _getUser();
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  _getSalesOrder() async {
    try {
      setState(() {
        isLoading = true;
      });

      SalesOrderRes response =
          await SalesOrderRepository().salesOrderApiCall(year: salesOrderYear);
      if (response.results!.isNotEmpty) {
        salesOrderAll = response.results!;
        _getClient();
      }
      return response;
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  _getClient() {
    for (int leadCount = 0; leadCount < salesOrderAll.length; leadCount++) {
      if (salesOrderAll[leadCount].client != null) {
        var contain = salesOrderAll.where((element) =>
            element.id.toString() ==
            salesOrderAll[leadCount].client!.id.toString());
        if (contain.isEmpty) {
          clientList.add(salesOrderAll[leadCount].client!);
        }
      }
    }
  }

  _getUser() async {
    try {
      setState(() {
        isLoading = true;
      });

      user.UserListRes response = await UserRepository().userApiCall();
      if (response.results!.isNotEmpty) {
        userList = response.results!;
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  _getSalesOrdersForSelectedClient() {
    salesOrder = [];
    for (int i = 0; i < salesOrderAll.length; i++) {
      if (salesOrderAll[i].client != null) {
        if (selectedClientID == salesOrderAll[i].client!.id) {
          salesOrder.add(salesOrderAll[i]);
        }
      }
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
                        child: DropdownButton<Org>(
                          dropdownColor: ColorConstant.whiteColor,
                          icon: const Icon(
                            Icons.keyboard_arrow_down_sharp,
                            color: ColorConstant.greyDarkColor,
                          ),
                          isExpanded: true,
                          items: clientList.map((Org value) {
                            return DropdownMenuItem<Org>(
                              value: value,
                              child: Text(
                                value.companyName ?? '',
                              ),
                            );
                          }).toList(),
                          style: const TextStyle(
                            color: ColorConstant.greyBlueColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                          hint: Text(
                            selectedClient,
                            maxLines: 1,
                            style: TextStyle(
                              color: selectedClient == "Please Select Client"
                                  ? ColorConstant.greyDarkColor
                                  : ColorConstant.bottomSheetColor,
                              fontSize: 16,
                              fontWeight:
                                  selectedClient == "Please Select Client"
                                      ? FontWeight.w400
                                      : FontWeight.w500,
                            ),
                          ),
                          onChanged: (value) {
                            selectedClient = value!.companyName!;
                            selectedClientID = value.id;
                            selectedSalesOrderID = null;
                            salesOrderName = "Select Sales Order";
                            _getSalesOrdersForSelectedClient();
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .02,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<SalesOrderData>(
                        dropdownColor: ColorConstant.whiteColor,
                        icon: const Icon(
                          Icons.keyboard_arrow_down_sharp,
                          color: ColorConstant.greyDarkColor,
                        ),
                        isExpanded: true,
                        items: salesOrder.map((SalesOrderData value) {
                          return DropdownMenuItem<SalesOrderData>(
                            value: value,
                            child: Text(
                              value.soId ?? '',
                            ),
                          );
                        }).toList(),
                        style: const TextStyle(
                          color: ColorConstant.greyBlueColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        hint: Text(
                          salesOrderName,
                          maxLines: 1,
                          style: TextStyle(
                            color: salesOrderName == "Select Sales Order"
                                ? ColorConstant.greyDarkColor
                                : ColorConstant.bottomSheetColor,
                            fontSize: 16,
                            fontWeight: salesOrderName == "Select Sales Order"
                                ? FontWeight.w400
                                : FontWeight.w500,
                          ),
                        ),
                        onChanged: (value) {
                          salesOrderName = value!.soId!;
                          selectedSalesOrderID = value.id;
                          if (value.client != null) {
                            selectedClientID = value.client!.id;
                            selectedClient = value.client!.companyName!;
                          }

                          setState(() {});
                        },
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
                      controller: projectName,
                      context: context,
                      hintText: 'Project Name',
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
                      isMaxLine: true,
                      controller: description,
                      context: context,
                      hintText: 'Description',
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
                      keyboardType: TextInputType.number,
                      controller: projectBudget,
                      context: context,
                      hintText: 'Budget',
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
                            'Indian Rupees',
                            'US Dollar',
                            'Euro',
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
                            selectedCurrency ?? "Please Select Currency",
                            maxLines: 1,
                            style: TextStyle(
                              color: selectedCurrency == null
                                  ? ColorConstant.greyDarkColor
                                  : ColorConstant.bottomSheetColor,
                              fontSize: 16,
                              fontWeight: selectedCurrency == null
                                  ? FontWeight.w400
                                  : FontWeight.w500,
                            ),
                          ),
                          onChanged: (value) {
                            if (value == "Indian Rupees") {
                              currency = "inr";
                            } else if (value == "US Dollar") {
                              currency = "inr";
                            } else {
                              currency = "inr";
                            }
                            selectedCurrency = value!;
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
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    border: Border.all(
                        width: 1, color: ColorConstant.greyBlueColor),
                    color: ColorConstant.whiteColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  height: 45,
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<user.UserData>(
                        dropdownColor: ColorConstant.whiteColor,
                        icon: const Icon(
                          Icons.keyboard_arrow_down_sharp,
                          color: ColorConstant.greyDarkColor,
                        ),
                        isExpanded: true,
                        items: userList.map((user.UserData value) {
                          return DropdownMenuItem<user.UserData>(
                            value: value,
                            child: Text(
                              value.lastName != null &&
                                      value.firstName != "null" &&
                                      value.firstName != ""
                                  ? "${value.firstName} ${value.lastName}"
                                  : value.firstName ?? '',
                            ),
                          );
                        }).toList(),
                        style: const TextStyle(
                          color: ColorConstant.greyBlueColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        hint: Text(
                          selectedProjectManager,
                          maxLines: 1,
                          style: TextStyle(
                            color: selectedProjectManager ==
                                    "Please Select Project Manager"
                                ? ColorConstant.greyDarkColor
                                : ColorConstant.bottomSheetColor,
                            fontSize: 16,
                            fontWeight: selectedProjectManager ==
                                    "Please Select Project Manager"
                                ? FontWeight.w400
                                : FontWeight.w500,
                          ),
                        ),
                        onChanged: (value) {
                          if (value!.lastName != null &&
                              value.lastName != "null" &&
                              value.lastName != "") {
                            selectedProjectManager =
                                value.firstName! + value.lastName!;
                          } else {
                            selectedProjectManager = value.firstName!;
                          }
                          selectedUserID = value.id;
                          setState(() {});
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .02,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * .44,
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
                                'Yes',
                                'No',
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
                                selectedSaleable,
                                maxLines: 1,
                                style: TextStyle(
                                  color: selectedSaleable ==
                                          "Please Select Saleable"
                                      ? ColorConstant.greyDarkColor
                                      : ColorConstant.bottomSheetColor,
                                  fontSize: 16,
                                  fontWeight: selectedSaleable ==
                                          "Please Select Saleable"
                                      ? FontWeight.w400
                                      : FontWeight.w500,
                                ),
                              ),
                              onChanged: (value) {
                                selectedSaleable = value!;
                                if (value == "Yes") {
                                  isSaleable = true;
                                } else {
                                  isSaleable = false;
                                }
                                setState(() {});
                              },
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * .44,
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
                                'Open',
                                'Close',
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
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .035,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: CommonButton(
                    onTap: () {
                      _createEngineeringProject();
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

  _createEngineeringProject() async {
    if (selectedClientID == null) {
      toastShow(message: "Please Select Client");
      return;
    }
    if (selectedSalesOrderID == null) {
      toastShow(message: "Please Select Sales Order");
      return;
    }
    if (projectName.text.isEmpty) {
      toastShow(message: "Please Enter Project Name");
      return;
    }
    if (description.text.isEmpty) {
      toastShow(message: "Please Enter Project Description");
      return;
    }
    if (projectBudget.text.isEmpty) {
      toastShow(message: "Please Enter Project Budget");
      return;
    }
    if (selectedCurrency == null) {
      toastShow(message: "Please Select Currency");
      return;
    }
    if (selectedUserID == null) {
      toastShow(message: "Please Select Project Manager");
      return;
    }
    if (isSaleable == null) {
      toastShow(message: "Please Select Saleable");
      return;
    }
    if (selectedStatus == null) {
      toastShow(message: "Please Select Saleable");
      return;
    }
    CommonRes response = await EngineeringRepository().createProjectApiCall(
        clientID: selectedClientID,
        description: description.text.trim(),
        projectBudget: projectBudget.text.trim(),
        projectCurrency: currency,
        projectManagerID: selectedUserID,
        projectName: projectName.text.trim(),
        saleable: isSaleable,
        salesOrderID: selectedSalesOrderID,
        status: selectedStatus);
    if (response.success == true) {
      toastShow(message: "Project Created Sussccefully");
      Get.to(() => const EngineeringDashBoardScreen());
    } else {
      toastShow(message: "Please try after again");
    }
  }
}
