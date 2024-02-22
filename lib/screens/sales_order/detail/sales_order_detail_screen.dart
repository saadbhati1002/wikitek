import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:wikitek/api/repository/sales_lead/sales_lead.dart';
import 'package:wikitek/api/repository/sales_order/sales_order.dart';
import 'package:wikitek/models/lead/part/part_model.dart';
import 'package:wikitek/models/sales_order/add_part/add_part_model.dart';
import 'package:wikitek/models/sales_order/sales_order_model.dart';
import 'package:wikitek/screens/sales_order/upload_document/upload_documents_screen.dart';

import 'package:wikitek/utility/colors.dart';
import 'package:wikitek/utility/constant.dart';
import 'package:wikitek/widgets/app_bar_detail.dart';
import 'package:wikitek/widgets/common_button.dart';
import 'package:wikitek/widgets/show_progress_bar.dart';

class SalesOrderDetailScreen extends StatefulWidget {
  final SalesOrderData? orderData;
  const SalesOrderDetailScreen({super.key, this.orderData});

  @override
  State<SalesOrderDetailScreen> createState() => _SalesOrderDetailScreenState();
}

class _SalesOrderDetailScreenState extends State<SalesOrderDetailScreen> {
  bool isLoading = false;
  SalesOrderData? salesOrder;
  bool isPartAdded = false;
  List<PartData> partList = [];
  PartData? selectedPart;
  String selectedPartName = "Select Part";
  @override
  void initState() {
    salesOrder = widget.orderData;
    _totalAmount();
    _getLeadParts();
    super.initState();
  }

  _getLeadParts() async {
    try {
      setState(() {
        isLoading = true;
      });
      PartLeadRes response = await SalesLeadRepository().getLeadPartsApiCall();
      if (response.results.isNotEmpty) {
        setState(() {
          partList = response.results;
        });
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  Future<bool> willPopScope() {
    Navigator.pop(
      context,
      jsonEncode(salesOrder),
    );

    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: willPopScope,
      child: Scaffold(
        backgroundColor: ColorConstant.backgroundColor,
        appBar: titleAppBarTitle(
          subHeading: salesOrder!.soId,
          onTap: () {
            Navigator.pop(
              context,
              json.encode(salesOrder!),
            );
          },
          context: context,
          title: 'Sales - Order',
          amount: salesOrder!.total != null
              ? double.parse(salesOrder!.total!).toStringAsFixed(2)
              : '',
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    child: Material(
                      borderRadius: BorderRadius.circular(5),
                      elevation: 1,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 20),
                        decoration: BoxDecoration(
                          color: ColorConstant.whiteColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Column(
                          children: [
                            commonRowDesign(
                              title: 'ORG',
                              heading: salesOrder!.org!.companyName ?? "",
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            commonRowDesign(
                              title: 'Client',
                              heading: salesOrder!.client!.companyName ?? "",
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            commonRowDesign(
                              title: 'Billing Add.',
                              heading:
                                  salesOrder!.billingAddress?.address ?? "",
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            commonRowDesign(
                              title: 'Shipping Add.',
                              heading:
                                  salesOrder!.shippingAddress?.address ?? "",
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            commonRowDesign(
                              title: 'Description',
                              heading: salesOrder!.description ?? "",
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            commonRowDesign(
                              title: 'Exp PO Date',
                              heading: salesOrder!.poDate ?? "",
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            commonRowDesign(
                              title: 'Exp Inv Date',
                              heading: salesOrder!.expectedInvDate ?? "",
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            commonRowDesign(
                              title: 'Department',
                              heading: salesOrder!.department?.name ?? "",
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            commonRowDesign(
                              title: 'Status',
                              heading: salesOrder!.soStatus ?? "",
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            commonRowDesign(
                                title: 'Contact No.',
                                heading: salesOrder!.contactTo?.lastName != null
                                    ? "${salesOrder!.contactTo?.firstName} ${salesOrder!.contactTo?.lastName}"
                                    : salesOrder!.contactTo?.firstName),
                            const SizedBox(
                              height: 15,
                            ),
                            commonRowDesign(
                              title: 'Mobile No',
                              heading: salesOrder!.contactTo?.mobile,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * .2,
                                  child: CommonButton(
                                    onTap: () {
                                      setState(() {
                                        isPartAdded = true;
                                      });
                                    },
                                    title: '+ Part',
                                    width: MediaQuery.of(context).size.width,
                                  ),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * .28,
                                  child: CommonButton(
                                    onTap: () async {
                                      var response = await Get.to(
                                        () => UploadSalesOrderDocumentsScreen(
                                          leadData: salesOrder,
                                        ),
                                      );
                                      if (response != null) {
                                        salesOrder = SalesOrderData.fromJson(
                                            jsonDecode(response));
                                        setState(() {});
                                      }
                                    },
                                    title: 'Document',
                                    width: MediaQuery.of(context).size.width,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  salesOrder!.parts.isEmpty
                      ? const SizedBox()
                      : ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          itemCount: salesOrder!.parts.length,
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
            isPartAdded == true ? addPart() : const SizedBox(),
            isLoading ? const ShowProgressBar() : const SizedBox(),
          ],
        ),
      ),
    );
  }

  Widget addPart() {
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
          height: MediaQuery.of(context).size.height * .52,
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
                        selectedPart = null;
                        selectedPartName = "Select Part";
                        isPartAdded = false;

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
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  color: ColorConstant.greenLightColor,
                  borderRadius: BorderRadius.circular(5),
                ),
                height: 45,
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<PartData>(
                      dropdownColor: ColorConstant.whiteColor,
                      icon: const Icon(
                        Icons.keyboard_arrow_down_sharp,
                        color: ColorConstant.greyDarkColor,
                      ),
                      isExpanded: true,
                      items: partList.map((PartData value) {
                        return DropdownMenuItem<PartData>(
                          value: value,
                          child: Text(
                            value.partNumber ?? '',
                          ),
                        );
                      }).toList(),
                      style: const TextStyle(
                        color: ColorConstant.greyBlueColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      hint: Text(
                        selectedPartName,
                        maxLines: 1,
                        style: TextStyle(
                          color: selectedPartName == "Select Part"
                              ? ColorConstant.greyBlueColor
                              : ColorConstant.bottomSheetColor,
                          fontSize: selectedPartName == "Select Part" ? 16 : 18,
                          fontWeight: selectedPartName == "Select Part"
                              ? FontWeight.w400
                              : FontWeight.w500,
                        ),
                      ),
                      onChanged: (value) {
                        selectedPartName = value!.partNumber!;
                        selectedPart = value;
                        calculateActualPrice();
                        setState(() {});
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .023,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: commonRowDesignPopUP(
                    title: 'Part No. ',
                    heading: selectedPart?.partNumber ?? "",
                    isBold: true),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .019,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: commonRowDesignPopUP(
                    title: 'Discretion',
                    heading: selectedPart?.shortDescription ?? "",
                    isBold: true),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .019,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: commonRowDesignPopUP(
                    title: 'Unit Price',
                    heading: selectedPart?.mrp.toString() ?? "",
                    isBold: true),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .019,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: commonRowDesignPopUP(
                    title: 'Price',
                    heading: selectedPart?.calculatedPrice!.toStringAsFixed(2),
                    isBold: true),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .023,
              ),
              selectedPart != null
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (selectedPart!.quantity != 1) {
                                selectedPart!.quantity =
                                    selectedPart!.quantity - 1;
                                calculateActualPrice();
                                setState(() {});
                              }
                            },
                            child: const Icon(
                              Icons.remove_circle,
                              size: 27,
                              color: ColorConstant.greyDarkColor,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * .05,
                            width: 80,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(22),
                              border: Border.all(
                                width: 1,
                                color: ColorConstant.greyDarkColor,
                              ),
                            ),
                            child: Text(
                              selectedPart!.quantity.toString(),
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: ColorConstant.greyDarkColor,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              selectedPart!.quantity =
                                  selectedPart!.quantity + 1;
                              calculateActualPrice();

                              setState(() {});
                            },
                            child: const Icon(
                              Icons.add_circle_outlined,
                              size: 27,
                              color: ColorConstant.greyDarkColor,
                            ),
                          ),
                        ],
                      ),
                    )
                  : SizedBox(
                      height: MediaQuery.of(context).size.height * .05,
                    ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .019,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: CommonButton(
                  onTap: () {
                    _addSalesLead();
                  },
                  title: 'Add Part',
                  width: MediaQuery.of(context).size.width,
                ),
              ),
            ],
          ),
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
                            salesOrder!.parts[index].partsId?.partNumber ?? '',
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
                            salesOrder!.parts[index].extendedGrossPrice ?? '',
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
                          width: MediaQuery.of(context).size.width * .75,
                          child: Text(
                            salesOrder!.parts[index].shortDescription ?? '',
                            maxLines: 1,
                            style: const TextStyle(
                                fontSize: 14,
                                fontFamily: "roboto",
                                color: ColorConstant.greyDarkColor,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        // Container(
                        //   alignment: Alignment.topRight,
                        //   width: MediaQuery.of(context).size.width * .2,
                        //   child: Text(
                        //     salesOrder!.parts![index]. ?? '',
                        //     maxLines: 1,
                        //     style: const TextStyle(
                        //         fontSize: 14,
                        //         fontFamily: "roboto",
                        //         color: ColorConstant.greyDarkColor,
                        //         fontWeight: FontWeight.w400),
                        //   ),
                        // ),
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

  Widget commonRowDesignPopUP({String? title, String? heading, bool? isBold}) {
    return SizedBox(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * .25,
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
              maxLines: 1,
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
      SalesOrderPartAddRes response = await SalesOrderRepository()
          .salesOrderUpdateApiCall(data: salesOrder, index: index);
      if (response.success == true) {
        _totalAmount();
        setState(() {});
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

  _addSalesLead() async {
    if (selectedPart == null) {
      toastShow(message: "Please select part to add ");
      return;
    }
    try {
      setState(() {
        isPartAdded = false;
        isLoading = true;
      });
      SalesOrderPartAddRes response = await SalesOrderRepository()
          .addSalesOrderUpdateApiCall(data: salesOrder, partData: selectedPart);
      if (response.success == true) {
        salesOrder!.parts.add(
          Parts(
            created: DateTime.now().toString(),
            extendedGrossPrice: selectedPart!.calculatedPrice.toString(),
            gst: selectedPart!.gstItm!.countryGst![0].gstPercent.toString(),
            netPrice: (selectedPart!.mrp! *
                    selectedPart!.gstItm!.countryGst![0].gstPercent!)
                .toString(),
            quantity: selectedPart!.quantity,
            shortDescription: selectedPart!.shortDescription,
            partsNo: PartsId(),
            price: selectedPart!.mrp,
          ),
        );
        salesOrder!.parts[salesOrder!.parts.length - 1].created =
            DateTime.now().toString();

        // salesOrder!.parts[salesOrder!.parts.length - 1].gst =
        //     selectedPart!.gstItm!.countryGst![0].gstPercent.toString();

        salesOrder!.parts[salesOrder!.parts.length - 1].netPrice =
            (selectedPart!.mrp! *
                    selectedPart!.gstItm!.countryGst![0].gstPercent!)
                .toString();

        salesOrder!.parts[salesOrder!.parts.length - 1].extendedGrossPrice =
            selectedPart!.calculatedPrice.toString();

        salesOrder!.parts[salesOrder!.parts.length - 1].price =
            selectedPart!.mrp;

        salesOrder!.parts[salesOrder!.parts.length - 1].quantity =
            selectedPart!.quantity;
        salesOrder!.parts[salesOrder!.parts.length - 1].shortDescription =
            selectedPart!.shortDescription;

        salesOrder!.parts[salesOrder!.parts.length - 1].partsId =
            PartsId(partNumber: selectedPart!.partNumber);

        salesOrder!.parts[salesOrder!.parts.length - 1].partsId =
            PartsId(id: selectedPart!.id);
        salesOrder!.parts[salesOrder!.parts.length - 1].partsId!.partNumber =
            selectedPart!.partNumber;
        salesOrder!.parts[salesOrder!.parts.length - 1].partsId!.id =
            selectedPart!.id;
        selectedPart = null;
        selectedPartName = "Select Part";
        _totalAmount();
        setState(() {});
        toastShow(message: "Added Successfully");
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

  _totalAmount() {
    dynamic totalValue = 0;
    for (int i = 0; i < salesOrder!.parts.length; i++) {
      if (salesOrder!.parts[i].extendedGrossPrice != null) {
        totalValue =
            totalValue + double.parse(salesOrder!.parts[i].extendedGrossPrice!);
      }
    }
    salesOrder!.total = totalValue.toString();
    setState(() {});
  }

  //calculate select part price
  calculateActualPrice() {
    selectedPart!.calculatedPrice = (selectedPart!.mrp! +
            ((selectedPart!.mrp! *
                    selectedPart!.gstItm!.countryGst![0].gstPercent!) /
                100)) *
        selectedPart!.quantity;
  }
}
