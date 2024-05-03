import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wikitek/api/repository/department/department.dart';
import 'package:wikitek/api/repository/sales_lead/sales_lead.dart';
import 'package:wikitek/api/repository/user/user.dart';
import 'package:wikitek/models/common_model.dart';
import 'package:wikitek/models/department/department_model.dart';
import 'package:wikitek/models/lead/lead_model.dart';
import 'package:wikitek/models/user/user_model.dart' as user;
import 'package:wikitek/utility/colors.dart';
import 'package:wikitek/utility/constant.dart';
import 'package:wikitek/widgets/app_bar_title.dart';
import 'package:wikitek/widgets/common_button.dart';
import 'package:wikitek/widgets/common_text_fields.dart';
import 'package:wikitek/widgets/show_progress_bar.dart';

class AddSalesLeadScreen extends StatefulWidget {
  const AddSalesLeadScreen({super.key});

  @override
  State<AddSalesLeadScreen> createState() => _AddSalesLeadScreenState();
}

class _AddSalesLeadScreenState extends State<AddSalesLeadScreen> {
  TextEditingController expectedInvoiceDateController = TextEditingController();
  TextEditingController expectedDateController = TextEditingController();
  TextEditingController customerNameController = TextEditingController();
  TextEditingController customerEmailController = TextEditingController();
  TextEditingController customerNumberController = TextEditingController();
  TextEditingController discretionController = TextEditingController();
  TextEditingController probabilityController = TextEditingController();
  TextEditingController partDescriptionController = TextEditingController();
  TextEditingController partQuantityController = TextEditingController();
  TextEditingController partPriceController = TextEditingController();
  String status = 'Status';
  bool isLoading = false;
  String? salesLeadYear = "2023 - 2024";
  List<SalesLeadData> allSalesLead = [];
  List<Org> clientList = [];
  List<user.UserData> userList = [];
  List<DepartmentData> departmentList = [];
  String departmentName = "Select Department";
  String clientName = "Select Client";
  String userName = "Customer Contact Name";

  String? selectedDepartmentID;
  String? selectedClientID;
  @override
  void initState() {
    _getLeads();

    super.initState();
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

  _getLeads() async {
    try {
      setState(() {
        isLoading = true;
      });

      SalesLeadRes response =
          await SalesLeadRepository().salesLeadApiCall(year: salesLeadYear);
      if (response.results!.isNotEmpty) {
        allSalesLead = response.results!;
        await _getDepartment(roleID: allSalesLead[0].department!.role!);
        _getClient();
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {}
  }

  Future _getDepartment({String? roleID}) async {
    try {
      setState(() {
        isLoading = true;
      });
      DepartmentRes response =
          await DepartmentRepository().departmentApiCall(roleID: roleID);
      if (response.results!.isNotEmpty) {
        departmentList = response.results!;
      }
      _getUser();
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  _getClient() {
    for (int leadCount = 0; leadCount < allSalesLead.length; leadCount++) {
      if (allSalesLead[leadCount].client != null) {
        var contain = clientList.where((element) =>
            element.id.toString() ==
            allSalesLead[leadCount].client!.id.toString());
        if (contain.isEmpty) {
          clientList.add(allSalesLead[leadCount].client!);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: ColorConstant.backgroundColor,
          appBar: titleAppBar(
            isHome: false,
            onTap: () {
              Navigator.pop(context);
            },
            context: context,
            title: 'New Sales Lead',
            amount: "",
            isAmount: false,
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                      child: DropdownButton<DepartmentData>(
                        dropdownColor: ColorConstant.whiteColor,
                        icon: const Icon(
                          Icons.keyboard_arrow_down_sharp,
                          color: ColorConstant.greyDarkColor,
                        ),
                        isExpanded: true,
                        items: departmentList.map((DepartmentData value) {
                          return DropdownMenuItem<DepartmentData>(
                            value: value,
                            child: Text(
                              value.name ?? '',
                            ),
                          );
                        }).toList(),
                        style: const TextStyle(
                          color: ColorConstant.greyBlueColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        hint: Text(
                          departmentName,
                          maxLines: 1,
                          style: TextStyle(
                            color: departmentName == "Select Department"
                                ? ColorConstant.greyDarkColor
                                : ColorConstant.bottomSheetColor,
                            fontSize: 16,
                            fontWeight: departmentName == "Select Department"
                                ? FontWeight.w400
                                : FontWeight.w500,
                          ),
                        ),
                        onChanged: (value) {
                          selectedDepartmentID = value!.id;
                          departmentName = value.org!;
                          setState(() {});
                        },
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
                          clientName,
                          maxLines: 1,
                          style: TextStyle(
                            color: clientName == "Select Client"
                                ? ColorConstant.greyDarkColor
                                : ColorConstant.bottomSheetColor,
                            fontSize: 16,
                            fontWeight: clientName == "Select Client"
                                ? FontWeight.w400
                                : FontWeight.w500,
                          ),
                        ),
                        onChanged: (value) {
                          selectedClientID = value!.id;
                          clientName = value.companyName!;
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
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .43,
                        child: CustomTextFormField(
                          onTap: () {
                            _selectDate(context);
                          },
                          controller: expectedDateController,
                          context: context,
                          hintText: 'Exp PO Date',
                          suffix: const Icon(
                            Icons.calendar_month_rounded,
                            color: ColorConstant.greyBlueColor,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .43,
                        child: CustomTextFormField(
                          onTap: () {
                            _selectExpectedInvoiceDate(context);
                          },
                          controller: expectedInvoiceDateController,
                          context: context,
                          hintText: 'Exp Inv Date',
                          suffix: const Icon(
                            Icons.calendar_month_sharp,
                            color: ColorConstant.greyBlueColor,
                          ),
                        ),
                      ),
                    ],
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
                          userName,
                          maxLines: 1,
                          style: TextStyle(
                            color: userName == "Customer Contact Name"
                                ? ColorConstant.greyDarkColor
                                : ColorConstant.blackColor,
                            fontSize: 16,
                            fontWeight: userName == "Customer Contact Name"
                                ? FontWeight.w400
                                : FontWeight.w500,
                          ),
                        ),
                        onChanged: (value) {
                          userName = value!.firstName!;
                          customerEmailController.text = value.email!;
                          customerNameController.text = value.firstName!;
                          customerNumberController.text = value.mobile!;

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
                  child: CustomTextFormField(
                    controller: customerNumberController,
                    context: context,
                    keyboardType: TextInputType.number,
                    hintText: 'Customer Contact Number',
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .02,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: CustomTextFormField(
                    controller: customerEmailController,
                    context: context,
                    keyboardType: TextInputType.emailAddress,
                    hintText: 'Customer Contact Email',
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .02,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: CustomTextFormField(
                    controller: discretionController,
                    context: context,
                    isMaxLine: true,
                    hintText: 'Discretion',
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
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .43,
                        child: CustomTextFormField(
                          controller: probabilityController,
                          context: context,
                          keyboardType: TextInputType.number,
                          hintText: 'Probability',
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * .43,
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
                                "Prospect",
                                "Approach",
                                "Qualify",
                                "Pitch",
                                "Handle Objections",
                                "Close the Deal",
                                "Lost Deal"
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
                                status,
                                maxLines: 1,
                                style: TextStyle(
                                  color: status == "Status"
                                      ? ColorConstant.greyDarkColor
                                      : ColorConstant.bottomSheetColor,
                                  fontSize: 16,
                                  fontWeight: status == "Status"
                                      ? FontWeight.w400
                                      : FontWeight.w500,
                                ),
                              ),
                              onChanged: (value) {
                                status = value!;
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
                  height: MediaQuery.of(context).size.height * .02,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    "Part Detail",
                    style: TextStyle(
                        fontSize: 20,
                        color: ColorConstant.blueDarkColor,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .02,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: CustomTextFormField(
                    controller: partPriceController,
                    context: context,
                    keyboardType: TextInputType.number,
                    hintText: 'Part Unit Price',
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * .06,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: CustomTextFormField(
                    controller: partQuantityController,
                    context: context,
                    keyboardType: TextInputType.number,
                    hintText: 'Part Quantity',
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .02,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: CustomTextFormField(
                    isMaxLine: true,
                    controller: partDescriptionController,
                    context: context,
                    hintText: 'Part Description',
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * .06,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CommonButton(
                    onTap: () {
                      _addSalesLead();
                    },
                    title: 'Save',
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * .06,
                ),
              ],
            ),
          ),
        ),
        isLoading ? const ShowProgressBar() : const SizedBox(),
      ],
    );
  }

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      expectedDateController.text = DateFormat('yyyy-MM-dd').format(picked);
      setState(() {});
    }
    FocusManager.instance.primaryFocus?.unfocus();
  }

  _selectExpectedInvoiceDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      expectedInvoiceDateController.text =
          DateFormat('yyyy-MM-dd').format(picked);
      setState(() {});
    }
    FocusManager.instance.primaryFocus?.unfocus();
  }

  _addSalesLead() async {
    if (selectedDepartmentID == null) {
      toastShow(message: "Please Select Department");
      return;
    }
    if (selectedClientID == null) {
      toastShow(message: "Please Select Client");
      return;
    }
    if (expectedDateController.text.isEmpty) {
      toastShow(message: "Please Select Exp PO Date");
      return;
    }
    if (expectedInvoiceDateController.text.isEmpty) {
      toastShow(message: "Please Select Exp Inv Date");
      return;
    }
    if (customerNameController.text.isEmpty) {
      toastShow(message: "Please Enter Customer Contact Name");
      return;
    }
    if (customerNumberController.text.isEmpty) {
      toastShow(message: "Please Enter Customer Contact Number");
      return;
    }
    if (customerNumberController.text.length != 10) {
      toastShow(message: "Please Enter Correct Customer Contact Name");
      return;
    }
    if (customerEmailController.text.isEmpty) {
      toastShow(message: "Please Enter Customer Contact Email");
      return;
    }
    if (discretionController.text.isEmpty) {
      toastShow(message: "Please Enter Discretion");
      return;
    }
    if (probabilityController.text.isEmpty) {
      toastShow(message: "Please Enter Probability");
      return;
    }
    if (status == "Status") {
      toastShow(message: "Please Select Status");
      return;
    }
    if (partPriceController.text.isEmpty) {
      toastShow(message: "Please Enter Part Unit Price");
      return;
    }
    if (partQuantityController.text.isEmpty) {
      toastShow(message: "Please Enter Part Quantity");
      return;
    }
    if (partDescriptionController.text.isEmpty) {
      toastShow(message: "Please Enter Part Description");
      return;
    }

    try {
      setState(() {
        isLoading = true;
      });
      FocusManager.instance.primaryFocus?.unfocus();

      CommonRes response = await SalesLeadRepository().addSalesLeadApiCall(
        clientID: selectedClientID,
        departmentId: selectedDepartmentID,
        description: discretionController.text.trim(),
        email: customerEmailController.text.trim(),
        expectedDate: expectedDateController.text.trim(),
        expectedInvoiceDate: expectedInvoiceDateController.text.trim(),
        mobileNumber: customerNumberController.text.trim(),
        name: customerNameController.text.trim(),
        probability: probabilityController.text.trim(),
        status: status,
        partDescription: partDescriptionController.text.trim(),
        partPrice: partPriceController.text.trim(),
        partQuantity: partQuantityController.text.trim(),
      );
      if (response.success == true) {
        selectedClientID = null;
        clientName = "Select Client";
        selectedDepartmentID = null;
        departmentName = "Select Department";
        status = "Status";
        expectedDateController.clear();
        expectedInvoiceDateController.clear();
        customerNameController.clear();
        customerNumberController.clear();
        customerEmailController.clear();
        discretionController.clear();
        probabilityController.clear();
        partDescriptionController.clear();
        partPriceController.clear();
        partQuantityController.clear();

        toastShow(message: "Sales Lead Added successfully");
      } else {}
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}
