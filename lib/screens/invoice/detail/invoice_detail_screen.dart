import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wikitek/models/invoice/invoice_model.dart';
import 'package:wikitek/screens/invoice/serial_number/serial_number_screen.dart';
import 'package:wikitek/utility/colors.dart';
import 'package:wikitek/widgets/app_bar_detail.dart';

class InvoiceDetailScreen extends StatefulWidget {
  final InvoiceData? invoiceData;
  const InvoiceDetailScreen({super.key, this.invoiceData});

  @override
  State<InvoiceDetailScreen> createState() => _InvoiceDetailScreenState();
}

class _InvoiceDetailScreenState extends State<InvoiceDetailScreen> {
  InvoiceData? invoiceData;
  @override
  void initState() {
    invoiceData = widget.invoiceData;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.backgroundColor,
      appBar: titleAppBarTitle(
        onTap: () {
          Navigator.pop(context);
        },
        context: context,
        title: 'Invoice Detail',
        subHeading: invoiceData!.invoiceNumber!,
        amount: invoiceData!.total != null
            ? double.parse(invoiceData!.total!).toStringAsFixed(2)
            : '',
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
                        heading: invoiceData!.org!.companyName ?? "",
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      commonRowDesign(
                        title: 'Billing Add.',
                        heading: invoiceData!.billingAddress?.address ?? "",
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      commonRowDesign(
                        title: 'Shipping Add.',
                        heading: invoiceData!.shippingAddress?.address ?? "",
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      commonRowDesign(
                        title: 'Description',
                        heading: invoiceData!.invoiceComment ?? "",
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      commonRowDesign(
                        title: 'Invoice Date',
                        heading: invoiceData!.invoiceDate ?? "",
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      commonRowDesign(
                        title: 'Payment Date',
                        heading: invoiceData!.paymentDate ?? "",
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      commonRowDesign(
                        title: 'Department',
                        heading: invoiceData!.dept?.name ?? "",
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      commonRowDesign(
                        title: 'Status',
                        heading: invoiceData!.status ?? "",
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      commonRowDesign(
                          title: 'Contact No.',
                          heading: invoiceData!
                                      .saleOrder!.contactTo?.lastName !=
                                  null
                              ? "${invoiceData!.saleOrder!.contactTo?.firstName} ${invoiceData!.saleOrder!.contactTo?.lastName}"
                              : invoiceData!.saleOrder!.contactTo?.firstName),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            invoiceData!.partsInvoice!.isEmpty
                ? const SizedBox()
                : ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    itemCount: invoiceData!.partsInvoice!.length,
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
              heading ?? '',
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

  Widget leadNotesWidget(index) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: GestureDetector(
        onTap: () {
          if (invoiceData!.partsInvoice![index].partsNo!.serialization!) {
            Get.to(
              () => SerialNumberScreen(
                invoiceNumber: invoiceData!.invoiceNumber,
                partNumber:
                    invoiceData!.partsInvoice![index].partsNo?.partNumber,
              ),
            );
          }
        },
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Material(
            elevation: 1,
            borderRadius: BorderRadius.circular(5),
            child: Container(
              width: MediaQuery.of(context).size.width * .75,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              decoration: BoxDecoration(
                color: invoiceData!.partsInvoice![index].partsNo!.serialization!
                    ? ColorConstant.yellowLightColor
                    : ColorConstant.whiteColor,
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
                          invoiceData!
                                  .partsInvoice![index].partsNo?.partNumber ??
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
                          invoiceData!.partsInvoice![index].price.toString(),
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
                          invoiceData!.partsInvoice![index].shortDescription ??
                              '',
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
      ),
    );
  }
}
