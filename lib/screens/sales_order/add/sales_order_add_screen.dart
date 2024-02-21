import 'package:flutter/material.dart';

import 'package:wikitek/api/repository/sales_lead/sales_lead.dart';
import 'package:wikitek/api/repository/sales_order/sales_order.dart';
import 'package:wikitek/models/common_model.dart';
import 'package:wikitek/models/lead/lead_model.dart';
import 'package:wikitek/models/organization/organization_model.dart';
import 'package:wikitek/models/sales_order/address/address_model.dart'
    as address;
import 'package:wikitek/models/sales_order/delivery_term/delivery_term_model.dart';
import 'package:wikitek/models/sales_order/payment_term/payment_term_model.dart';
import 'package:wikitek/models/sales_order/transportation_term/transportation_term_model.dart';
import 'package:wikitek/utility/colors.dart';
import 'package:wikitek/utility/constant.dart';
import 'package:wikitek/widgets/app_bar_title.dart';
import 'package:wikitek/widgets/common_button.dart';
import 'package:wikitek/widgets/common_text_fields.dart';
import 'package:wikitek/widgets/show_progress_bar.dart';

class SalesOrderAddScreen extends StatefulWidget {
  const SalesOrderAddScreen({super.key});

  @override
  State<SalesOrderAddScreen> createState() => _SalesOrderAddScreenState();
}

class _SalesOrderAddScreenState extends State<SalesOrderAddScreen> {
  TextEditingController refPONo = TextEditingController();
  TextEditingController pODate = TextEditingController();
  TextEditingController customerName = TextEditingController();
  TextEditingController expectedInvoiceData = TextEditingController();
  TextEditingController discretion = TextEditingController();
  bool isLoading = false;
  bool isOrderCreated = false;

  String salesLeadName = "Select Sales Lead";
  String salesDepartment = "Department";
  String salesClient = "Client";
  String? salesLeadYear = "2023 - 2024";
  String statusSelected = "Status";
  String billingAddress = "Select Billing Address";
  String shippingAddress = "Select Shipping Address";
  String transportation = "Transportation Term";
  String payment = "Payment Term";
  String delivery = "Delivery Term";
  int? transportationID;
  int? deliveryID;
  int? paymentID;
  String? billingAddressID;
  String? shippingAddressID;
  SalesLeadData? selectedSalesLead;
  String? contactToID;

  List<SalesLeadData> allSalesLead = [];
  List<Department> salesDepartmentList = [];
  List<OrganizationData> organizationList = [];
  List<address.AddressData> selectedBillingAddress = [];
  List<address.AddressData> selectedShippingAddress = [];
  List<Org> salesClientList = [];
  List<OrganizationData> selectedOrganization = [];
  List<TransportationData> transportationTermList = [];
  List<DeliveryTermData> deliveryTermList = [];
  List<PaymentTermData> paymentTermList = [];
  @override
  void initState() {
    _getLeads();
    super.initState();
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
      }
      _remainingApis();
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  _remainingApis() async {
    await _getPaymentTerm();
    await _getDeliveryTerm();
    await _getTransportationTerm();
  }

  _getPaymentTerm() async {
    try {
      setState(() {
        isLoading = true;
      });
      PaymentTermRes response =
          await SalesOrderRepository().paymentTermApiCall();
      if (response.results!.isNotEmpty) {
        paymentTermList = response.results!;
      }

      return paymentTermList;
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  _getDeliveryTerm() async {
    try {
      setState(() {
        isLoading = true;
      });
      DeliveryTermRes response =
          await SalesOrderRepository().deliveryTermApiCall();
      if (response.results!.isNotEmpty) {
        deliveryTermList = response.results!;
      }

      return deliveryTermList;
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  _getTransportationTerm() async {
    try {
      setState(() {
        isLoading = true;
      });
      TransportationTermRes response =
          await SalesOrderRepository().transportationTermApiCall();
      if (response.results!.isNotEmpty) {
        transportationTermList = response.results!;
      }

      return deliveryTermList;
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  _getAddress({String? organizationID}) async {
    billingAddress = "Select Billing Address";
    shippingAddress = "Select Shipping Address";
    billingAddressID = null;
    shippingAddressID = null;
    try {
      setState(() {
        isLoading = true;
      });
      address.AddressRes response = await SalesOrderRepository()
          .addressListApiCall(organizationID: organizationID);
      if (response.results!.isNotEmpty) {
        selectedBillingAddress = response.results!;
        selectedShippingAddress = response.results!;
      }
      if (selectedBillingAddress.isNotEmpty) {
        contactToID = selectedBillingAddress[0].org?.contactPerson?.id;
        if (selectedBillingAddress[0].org?.contactPerson?.lastName != null) {
          customerName.text =
              "${selectedBillingAddress[0].org!.contactPerson!.firstName} ${selectedBillingAddress[0].org!.contactPerson!.lastName}";
        } else {
          customerName.text = selectedBillingAddress[0]
              .org!
              .contactPerson!
              .firstName!
              .toString();
        }
      }

      return deliveryTermList;
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<bool> willPopScope() {
    if (isOrderCreated) {
      Navigator.pop(context, 1);
    } else {
      Navigator.pop(context, 0);
    }
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
            if (isOrderCreated) {
              Navigator.pop(context, 1);
            } else {
              Navigator.pop(context, 0);
            }
          },
          context: context,
          title: 'New Sales Order',
          amount: "",
          isAmount: false,
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 3),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<SalesLeadData>(
                          dropdownColor: ColorConstant.whiteColor,
                          icon: const Icon(
                            Icons.keyboard_arrow_down_sharp,
                            color: ColorConstant.greyDarkColor,
                          ),
                          isExpanded: true,
                          items: allSalesLead.map((SalesLeadData value) {
                            return DropdownMenuItem<SalesLeadData>(
                              value: value,
                              child: Text(
                                value.leadId ?? '',
                              ),
                            );
                          }).toList(),
                          style: const TextStyle(
                            color: ColorConstant.greyBlueColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                          hint: Text(
                            salesLeadName,
                            maxLines: 1,
                            style: TextStyle(
                              color: salesLeadName == "Select Sales Lead"
                                  ? ColorConstant.greyDarkColor
                                  : ColorConstant.bottomSheetColor,
                              fontSize: 16,
                              fontWeight: salesLeadName == "Select Sales Lead"
                                  ? FontWeight.w400
                                  : FontWeight.w500,
                            ),
                          ),
                          onChanged: (value) {
                            salesLeadName = value!.leadId!;
                            salesDepartment = value.department!.name!;
                            salesClient = value.client!.companyName!;
                            salesDepartmentList = [value.department!];
                            salesClientList = [value.client!];
                            pODate.text = value.expectedDate!;

                            expectedInvoiceData.text =
                                value.expectedInvoiceDate!;
                            selectedSalesLead = value;
                            _getAddress(organizationID: value.org?.id);
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
                          width: MediaQuery.of(context).size.width * .44,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 3),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<Department>(
                                dropdownColor: ColorConstant.whiteColor,
                                icon: const Icon(
                                  Icons.keyboard_arrow_down_sharp,
                                  color: ColorConstant.greyDarkColor,
                                ),
                                isExpanded: true,
                                items:
                                    salesDepartmentList.map((Department value) {
                                  return DropdownMenuItem<Department>(
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
                                  salesDepartment,
                                  maxLines: 1,
                                  style: TextStyle(
                                    color: salesDepartment == "Department"
                                        ? ColorConstant.greyDarkColor
                                        : ColorConstant.bottomSheetColor,
                                    fontSize: 16,
                                    fontWeight: salesDepartment == "Department"
                                        ? FontWeight.w400
                                        : FontWeight.w500,
                                  ),
                                ),
                                onChanged: (value) {
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
                                  'Paid',
                                  'Unpaid',
                                  'Closed',
                                  "Invoiced"
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
                                  statusSelected,
                                  maxLines: 1,
                                  style: TextStyle(
                                    color: statusSelected == "Status"
                                        ? ColorConstant.greyDarkColor
                                        : ColorConstant.bottomSheetColor,
                                    fontSize: 16,
                                    fontWeight: statusSelected == "Status"
                                        ? FontWeight.w400
                                        : FontWeight.w500,
                                  ),
                                ),
                                onChanged: (value) {
                                  statusSelected = value!;
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
                          items: salesClientList.map((Org value) {
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
                            salesClient,
                            maxLines: 1,
                            style: TextStyle(
                              color: salesClient == "Client"
                                  ? ColorConstant.greyDarkColor
                                  : ColorConstant.bottomSheetColor,
                              fontSize: 16,
                              fontWeight: salesClient == "Client"
                                  ? FontWeight.w400
                                  : FontWeight.w500,
                            ),
                          ),
                          onChanged: (value) {},
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
                          width: MediaQuery.of(context).size.width * .44,
                          child: CustomTextFormField(
                            controller: refPONo,
                            context: context,
                            hintText: 'Ref PO No.',
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .44,
                          child: CustomTextFormField(
                            controller: pODate,
                            context: context,
                            hintText: 'PO Date',
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
                        child: DropdownButton<address.AddressData>(
                          dropdownColor: ColorConstant.whiteColor,
                          icon: const Icon(
                            Icons.keyboard_arrow_down_sharp,
                            color: ColorConstant.greyDarkColor,
                          ),
                          isExpanded: true,
                          items: selectedBillingAddress
                              .map((address.AddressData value) {
                            return DropdownMenuItem<address.AddressData>(
                              value: value,
                              child: Text(
                                value.address ?? '',
                              ),
                            );
                          }).toList(),
                          style: const TextStyle(
                            color: ColorConstant.greyBlueColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                          hint: Text(
                            billingAddress,
                            maxLines: 1,
                            style: TextStyle(
                              color: billingAddress == "Select Billing Address"
                                  ? ColorConstant.greyDarkColor
                                  : ColorConstant.bottomSheetColor,
                              fontSize: 16,
                              fontWeight:
                                  billingAddress == "Select Billing Address"
                                      ? FontWeight.w400
                                      : FontWeight.w500,
                            ),
                          ),
                          onChanged: (value) {
                            billingAddress = value!.address!;
                            billingAddressID = value.id;
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
                        child: DropdownButton<address.AddressData>(
                          dropdownColor: ColorConstant.whiteColor,
                          icon: const Icon(
                            Icons.keyboard_arrow_down_sharp,
                            color: ColorConstant.greyDarkColor,
                          ),
                          isExpanded: true,
                          items: selectedShippingAddress
                              .map((address.AddressData value) {
                            return DropdownMenuItem<address.AddressData>(
                              value: value,
                              child: Text(
                                value.address ?? '',
                              ),
                            );
                          }).toList(),
                          style: const TextStyle(
                            color: ColorConstant.greyBlueColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                          hint: Text(
                            shippingAddress,
                            maxLines: 1,
                            style: TextStyle(
                              color:
                                  shippingAddress == "Select Shipping Address"
                                      ? ColorConstant.greyDarkColor
                                      : ColorConstant.bottomSheetColor,
                              fontSize: 16,
                              fontWeight:
                                  shippingAddress == "Select Shipping Address"
                                      ? FontWeight.w400
                                      : FontWeight.w500,
                            ),
                          ),
                          onChanged: (value) {
                            shippingAddress = value!.address!;
                            shippingAddressID = value.id;
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
                          width: MediaQuery.of(context).size.width * .44,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 3),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<PaymentTermData>(
                                dropdownColor: ColorConstant.whiteColor,
                                icon: const Icon(
                                  Icons.keyboard_arrow_down_sharp,
                                  color: ColorConstant.greyDarkColor,
                                ),
                                isExpanded: true,
                                items: paymentTermList
                                    .map((PaymentTermData value) {
                                  return DropdownMenuItem<PaymentTermData>(
                                    value: value,
                                    child: Text(
                                      value.term ?? '',
                                    ),
                                  );
                                }).toList(),
                                style: const TextStyle(
                                  color: ColorConstant.greyBlueColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                                hint: Text(
                                  payment,
                                  maxLines: 1,
                                  style: TextStyle(
                                    color: payment == "Payment Term"
                                        ? ColorConstant.greyDarkColor
                                        : ColorConstant.bottomSheetColor,
                                    fontSize: 16,
                                    fontWeight: payment == "Payment Term"
                                        ? FontWeight.w400
                                        : FontWeight.w500,
                                  ),
                                ),
                                onChanged: (value) {
                                  payment = value!.term!;
                                  paymentID = value.id!;
                                  setState(() {});
                                },
                              ),
                            ),
                          ),
                        ),
                        Container(
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
                          width: MediaQuery.of(context).size.width * .44,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 3),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<DeliveryTermData>(
                                dropdownColor: ColorConstant.whiteColor,
                                icon: const Icon(
                                  Icons.keyboard_arrow_down_sharp,
                                  color: ColorConstant.greyDarkColor,
                                ),
                                isExpanded: true,
                                items: deliveryTermList
                                    .map((DeliveryTermData value) {
                                  return DropdownMenuItem<DeliveryTermData>(
                                    value: value,
                                    child: Text(
                                      value.term ?? '',
                                    ),
                                  );
                                }).toList(),
                                style: const TextStyle(
                                  color: ColorConstant.greyBlueColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                                hint: Text(
                                  delivery,
                                  maxLines: 1,
                                  style: TextStyle(
                                    color: delivery == "Delivery Term"
                                        ? ColorConstant.greyDarkColor
                                        : ColorConstant.bottomSheetColor,
                                    fontSize: 16,
                                    fontWeight: delivery == "Delivery Term"
                                        ? FontWeight.w400
                                        : FontWeight.w500,
                                  ),
                                ),
                                onChanged: (value) {
                                  delivery = value!.term!;
                                  deliveryID = value.id!;
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: CustomTextFormField(
                        controller: customerName,
                        context: context,
                        hintText: 'Customer Contact',
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
                          width: MediaQuery.of(context).size.width * .44,
                          child: CustomTextFormField(
                            controller: expectedInvoiceData,
                            context: context,
                            hintText: 'Exp Inv Date',
                            suffix: const Icon(
                              Icons.calendar_month_rounded,
                              color: ColorConstant.greyBlueColor,
                            ),
                          ),
                        ),
                        Container(
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
                          width: MediaQuery.of(context).size.width * .44,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 3),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<TransportationData>(
                                dropdownColor: ColorConstant.whiteColor,
                                icon: const Icon(
                                  Icons.keyboard_arrow_down_sharp,
                                  color: ColorConstant.greyDarkColor,
                                ),
                                isExpanded: true,
                                items: transportationTermList
                                    .map((TransportationData value) {
                                  return DropdownMenuItem<TransportationData>(
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
                                  transportation,
                                  maxLines: 1,
                                  style: TextStyle(
                                    color:
                                        transportation == "Transportation Term"
                                            ? ColorConstant.greyDarkColor
                                            : ColorConstant.bottomSheetColor,
                                    fontSize: 16,
                                    fontWeight:
                                        transportation == "Transportation Term"
                                            ? FontWeight.w400
                                            : FontWeight.w500,
                                  ),
                                ),
                                onChanged: (value) {
                                  transportation = value!.name!;
                                  transportationID = value.id!;
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: CustomTextFormField(
                        isMaxLine: true,
                        controller: discretion,
                        context: context,
                        hintText: 'Discretion',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .035,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: CommonButton(
                      onTap: () {
                        _addSalesOrder();
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
      ),
    );
  }

  _addSalesOrder() async {
    if (selectedSalesLead == null) {
      toastShow(message: "Please Select Sales Lead");
      return;
    }
    if (salesDepartment == "Department") {
      toastShow(message: "Please Select department");
      return;
    }
    if (statusSelected == "Status") {
      toastShow(message: "Please Select Status");
      return;
    }
    if (salesClient == "Client") {
      toastShow(message: "Please Select Client");
      return;
    }

    if (refPONo.text.isEmpty) {
      toastShow(message: "Please Enter Ref PO No.");
      return;
    }
    if (pODate.text.isEmpty) {
      toastShow(message: "Please Select PO Date");
      return;
    }
    if (billingAddress == "Select Billing Address") {
      toastShow(message: "Please Select Billing Address");
      return;
    }
    if (shippingAddress == 'Select Shipping Address') {
      toastShow(message: "Please Select Shipping Address");
      return;
    }
    if (paymentID == null) {
      toastShow(message: "Please Select Payment Term");
      return;
    }
    if (deliveryID == null) {
      toastShow(message: "Please Select Delivery Term");
      return;
    }
    if (customerName.text.isEmpty) {
      toastShow(message: "Please Select Customer Contact");
      return;
    }
    if (expectedInvoiceData.text.isEmpty) {
      toastShow(message: "Please Select Expected Invoice Date");
      return;
    }
    if (transportationID == null) {
      toastShow(message: "Please Select Transportation Term");
      return;
    }
    if (discretion.text.isEmpty) {
      toastShow(message: "Please Enter Discretion Invoice Date");
      return;
    }

    try {
      setState(() {
        isLoading = true;
      });
      FocusManager.instance.primaryFocus?.unfocus();

      CommonRes response = await SalesOrderRepository().createSalesOrderApiCall(
          billingAddress: billingAddressID,
          clientID: selectedSalesLead?.client?.id,
          contactTo: contactToID,
          deliveryTerm: deliveryID,
          discretion: discretion.text.toString(),
          paymentTerm: paymentID,
          expectedINvoiceData: expectedInvoiceData.text.trim(),
          poData: pODate.text.trim(),
          refPO: refPONo.text.trim(),
          shippingAddress: shippingAddressID,
          status: statusSelected,
          organizationID: selectedSalesLead?.org?.id,
          salesLeadID: selectedSalesLead!.leadNo,
          transportationID: transportationID);
      if (response.success == true) {
        isOrderCreated = true;
        expectedInvoiceData.clear();
        refPONo.clear();
        pODate.clear();
        discretion.clear();
        customerName.clear();
        salesLeadName = "Select Sales Lead";
        salesDepartment = "Department";
        salesClient = "Client";

        statusSelected = "Status";
        billingAddress = "Select Billing Address";
        shippingAddress = "Select Shipping Address";
        transportation = "Transportation Term";
        payment = "Payment Term";
        delivery = "Delivery Term";

        transportationID = null;
        deliveryID = null;
        paymentID = null;
        selectedSalesLead = null;
        selectedBillingAddress = [];
        selectedShippingAddress = [];
        setState(() {});
        toastShow(message: "Sales Order Added successfully");
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
